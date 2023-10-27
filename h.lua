local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CurrentCamera = workspace.CurrentCamera
local Player = game.Players.LocalPlayer

local NOCLIP_SPEED = 128
local MAX_VELOCITY_GROUND = 16
local MAX_VELOCITY_AIR = 4
local GROUND_ACCELERATE = 250
local AIR_ACCELERATE = 24000
local FRICTION = 5

local INVERSE_XZ_Z = Vector3.new(1, 0, -1)
local GROUND_HIP_HEIGHT = Vector3.new(0, -4, 0)
local AIR_HIP_HEIGHT = Vector3.new(0, -3.2, 0)
local HIP_HEIGHT_ACTUAL = 3
local DIRECTIONS = {
	Vector3.new(0, 0, 1);
	Vector3.new(0, 0, -1);
	Vector3.new(1, 0, 0);
	Vector3.new(-1, 0, 0);
	Vector3.new(0, 0, 0);
}

local XZ = Vector3.new(1, 0, 1)

local DEFAULT = PhysicalProperties.new(Enum.Material.Plastic)
local SLIPPY = PhysicalProperties.new(0.2, 0, 0, 100, 100)

local GroundStates = {
	[Enum.HumanoidStateType.Running] = true;
	[Enum.HumanoidStateType.RunningNoPhysics] = true;
}

local AirStates = {
	[Enum.HumanoidStateType.Jumping] = true;
	[Enum.HumanoidStateType.Landed] = true;
	[Enum.HumanoidStateType.Freefall] = true;
}

local function accelerate(accelDir, prevVelocity, accelerate, maxVelocity, deltaTime)
	local projVel = prevVelocity:Dot(accelDir)
	local accelVel = accelerate * deltaTime

	if projVel + accelVel > maxVelocity then
		accelVel = math.max(maxVelocity - projVel, 0)
	end

	local result=(prevVelocity + accelDir * accelVel)
	return result
end

local function moveGround(accelDir, prevVelocity, deltaTime)
	local speed = prevVelocity.Magnitude
	if (speed ~= 0) then
		local drop = speed * FRICTION * deltaTime
		prevVelocity = prevVelocity * math.max(speed - drop, 0) / speed
	end

	return accelerate(accelDir, prevVelocity, GROUND_ACCELERATE, MAX_VELOCITY_GROUND, deltaTime)*XZ
end

local function moveAir(accelDir, prevVelocity, deltaTime)
	return accelerate(accelDir, prevVelocity, AIR_ACCELERATE, MAX_VELOCITY_AIR, deltaTime)*XZ
end

local function safe_unit(unit)
	if (unit.Magnitude>0) then
		return unit.Unit
	end
	return Vector3.new()
end

local function IsKeyDown(key)
	local UisIsKeyDown = UserInputService:IsKeyDown(key)

	if UserInputService:GetFocusedTextBox() then return false end
	return UisIsKeyDown
end

local scripts={"FallDamageScript","CustomSounds","WallRunning","HumanoidUpdate","HumanoidSurfaceDetect","HumanoidControl"}
local xz=Vector3.new(1,0,1)
local function onCharacterAdded(character)
	RunService:UnbindFromRenderStep("name")
	for _,script in pairs(scripts)do if(character:FindFirstChild(script))then character[script]:Destroy()end end
	local humanoid = character:WaitForChild("Humanoid",1)
	local root = character:WaitForChild("HumanoidRootPart",1)
	root.CustomPhysicalProperties = SLIPPY

	local wishDir = Vector3.new()
	local input = Vector3.new()

	local params = RaycastParams.new()
	local ignore = workspace:FindFirstChild("Ignore") or Instance.new("Folder", workspace)
	params.CollisionGroup = "Default"
	params.FilterDescendantsInstances = {character, workspace.CurrentCamera, ignore}
	if(humanoid)then humanoid.HipHeight = -2 end

	local function isGrounded(hipHeight)
		local origin = root.Position
		local hit, position, normal = nil, Vector3.new(0, -20000, 0), Vector3.new()
		local mid = workspace:Raycast(origin,hipHeight*3,params)
		for _, direction in pairs(DIRECTIONS) do
			local result = workspace:Raycast(
				origin+direction,
				hipHeight,
				params
			)
			if (not result) then
				continue
			end
			if (result.Position.Y>position.Y and (mid and (result.Position.Y-mid.Position.Y)<0.5)) then
				if (result.Instance.Parent:FindFirstChild("Humanoid") or result.Instance.Parent.Parent:FindFirstChild("Humanoid")) then
					continue
				elseif (not result.Instance.CanCollide) then
					result.Instance.Parent=ignore
					continue
				end
				hit=result.Instance
				position=result.Position
				normal=result.Normal
			end
		end
		return hit, position, normal
	end

	humanoid.HipHeight=-2
	local delta = 0
	local floor = root.Position.Y-HIP_HEIGHT_ACTUAL

	local bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.MaxForce = Vector3.new(1,1,1)*math.huge
	local airState
	local groundState
	local ladderState
	local noclipState
	local state

	local look = CFrame.new()
	local lastJump=tick()

	local function noclipInput()
		local cframe = CurrentCamera.CFrame
		return (cframe.LookVector*input.Z)+(cframe.RightVector*input.X)
	end

	local function isJumping()
		return IsKeyDown(Enum.KeyCode.Space)
	end

	local function canClimb(direction)
		local origin = root.Position
		local diffs = 0
		local isAir = true
		for i = -1, 1, -0.3 do
			local result = workspace:Raycast(origin + Vector3.new(0, i, 0), direction)
			local airFlag = result ~= nil
			if (airFlag~=isAir) then
				isAir = airFlag
				diffs = diffs + 1
			end
			if (result and result.Instance and result.Instance:IsA("TrussPart")) then
				return true
			end
		end

		return diffs>=2
	end

	noclipState = function(dt)
		local delta=noclipInput()*NOCLIP_SPEED
		root.Velocity = delta
		root.CFrame = root.CFrame + delta*dt
	end

	ladderState = function(dt)
		bodyVelocity.Parent=root
		local up = CurrentCamera.CFrame.LookVector:Dot(Vector3.new(0,1,0))
		local speed = input.Magnitude*MAX_VELOCITY_GROUND
		local vertical = math.sign(up)*speed
		local position = root.Position
		bodyVelocity.Velocity = Vector3.new(0,vertical,0)
		if (not canClimb(look.LookVector*1.5))then
			bodyVelocity.Parent = nil
			state=airState
			return
		end
	end

	for _,bodyMover in pairs(root:GetDescendants())do
		if(bodyMover:IsA("BodyMover"))then
			bodyMover.Parent=nil
		end
	end

	local footstep=Instance.new("Sound")
	footstep.SoundId="rbxassetid://267882824"
	footstep.Parent=root
	local distance=0
	groundState = function(dt)
		local hit, pos, normal = isGrounded(GROUND_HIP_HEIGHT)
		local horiz=(root.Velocity*xz)
		if(not hit) then
			root.Velocity=root.Velocity+Vector3.new(0,math.max(-horiz:Dot(normal*xz),0),0)
			state=airState
			return
		end
		if(math.abs(pos.Y-floor)>10)then return end
		delta = delta+pos.Y-floor
		floor=pos.Y
		local position=root.Position
		delta=delta-math.min(math.abs(delta),math.min(dt*root.Velocity.Magnitude,1))*math.sign(delta)
		delta=math.clamp(delta,-0.5,0.5)
		root.CFrame=CFrame.new(position.X,pos.Y+HIP_HEIGHT_ACTUAL-delta,position.Z)
		if(normal.Y<0.9)then
			root.Velocity=root.Velocity+((1/normal.Y)*normal*60*dt)  
			root.Velocity=moveAir(wishDir,root.Velocity-hit.Velocity,dt)+hit.Velocity
		else
			root.Velocity=moveGround(wishDir,root.Velocity-hit.Velocity,dt)+hit.Velocity
		end
		distance=distance+(horiz.Magnitude*dt*wishDir.Magnitude)
		if(distance>6)then
			footstep.TimePosition=0
			footstep.Playing=true
			distance=0
		elseif(horiz.Magnitude<5)then
			footstep.Playing=false
		end
		if (isJumping()) then
			footstep:Play()
			local previous = root.Velocity
			root.Velocity = Vector3.new(previous.X, humanoid and humanoid.JumpPower or 15, previous.Z)
			root.Velocity=root.Velocity+Vector3.new(0,math.max(-horiz:Dot(normal*xz),0),0)
			state=airState
			lastJump=tick()+0.03
			return
		end
		if (canClimb(wishDir))then
			state=ladderState
			return
		end

	end
	airState = function(dt)
		local hit, pos, normal = isGrounded(AIR_HIP_HEIGHT)
		if(hit and lastJump<=tick()) then
			floor=pos.Y
			state=groundState
			state(dt)
			return
		end
		if (canClimb(wishDir))then
			state=ladderState
			return
		end
		root.Velocity=moveAir(wishDir,root.Velocity,dt)+Vector3.new(0,root.Velocity.Y,0)
	end

	local function getInput()
		return Vector3.new(
			IsKeyDown(Enum.KeyCode.A) and -1 or IsKeyDown(Enum.KeyCode.D) and 1 or 0, 
			0,
			IsKeyDown(Enum.KeyCode.W) and 1 or IsKeyDown(Enum.KeyCode.S) and -1 or 0
		)
	end

	state=airState
	RunService:BindToRenderStep("name", Enum.RenderPriority.Camera.Value-1, function(dt)
		if(humanoid)then humanoid.PlatformStand = true end
		local _,y = CurrentCamera.CFrame:ToOrientation()
		look = CFrame.Angles(0,y,0)
		input = getInput()
		wishDir=safe_unit((look.LookVector*input.Z)+(look.RightVector*input.X))
		state(dt)

		root.CFrame = CFrame.new(root.Position)*look
		root.RotVelocity = Vector3.new()
	end)

	UserInputService.InputBegan:Connect(function(key, processed)
		if(key.KeyCode==Enum.KeyCode.V) then
			root.Anchored = true
			state=noclipState
		end
	end)
	UserInputService.InputEnded:Connect(function(key, processed)
		if(key.KeyCode==Enum.KeyCode.V) then
			root.Anchored = false
			state=groundState
		end
	end)

	if(humanoid)then humanoid.Died:Connect(function()RunService:UnbindFromRenderStep("name")end)end
end

onCharacterAdded(Player.Character or Player.CharacterAdded:Wait())
