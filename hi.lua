if "do some nice setup" then
    local player = game.Players.LocalPlayer
    local chr = player.Character
    local humanoid = chr.Humanoid
    
    if chr:FindFirstChild("Animate") then
        chr.Animate:Destroy()
    end
    
    humanoid.AutoRotate = false
    
   local AnimationTracks = humanoid:GetPlayingAnimationTracks()
    for i, track in pairs(AnimationTracks) do
    	track:Stop()
    end
end

local EVILCONNECTIONS = {}


local vector={}
local cframe={}
local network={}
local trash={}
local event={}
local sequencer={}
local physics={}
local tween={}
local animation={}
local input={}
local camera= workspace.CurrentCamera
local replication={}
local run={}
local char={}
local gamelogic={}


function KillConnections()
	 vector=nil
	 cframe=nil
	 network=nil
	 trash=nil
	 event=nil
	 sequencer=nil
	 physics=nil
	 tween=nil
	 animation=nil
	 input=nil
	 replication=nil
	 run=nil
	 char=nil
	 gamelogic=nil
	
	for i in pairs(EVILCONNECTIONS) do
		EVILCONNECTIONS[i]:Disconnect()
		EVILCONNECTIONS[i] = nil
	end
	script:Destroy()
end

--LOLTASTIC Good for figuring out bugs.
--leleltru=({Player=true;Player1=true;Player2=true;AxisAngle=true;litozinnamon=true;shaylan007=true,Buddyism=true;Quaternions=true;LuaWeaver=true;QuaternionsIsAdolf=true;})[game.Players.LocalPlayer.Name]
leleltru=({AxisAngle=true;litozinnamon=true;shaylan007=true;Buddyism=true;Forbidden_Croissant=true})[game.Players.LocalPlayer.Name]

local loltimescale=1
local lolgravity=Vector3.new(0,-196.2,0)
print(lolgravity)
local loltick=tick
local function tick()
	return loltimescale*loltick()
end
game.StarterGui.ResetPlayerGuiOnSpawn=false

math.randomseed(tick())
local realprint=print
--local print=function() end


if loltimescale>=2 then
	local s=Instance.new("Sound",game.Workspace)
	s.SoundId="http://roblox.com/asset/?id=145542130"
	s.Looped=true
	s:Play()
end


--- CAMO TESTING
if leleltru then
	game.ReplicatedStorage.GunModels["SCAR-L"]:Destroy()
	game.ReplicatedStorage.GunModels["spSCAR-L"].Name="SCAR-L"
end
---


--vector module
--By AxisAngle (Trey Reynolds)
print("Loading vector module")
do
	local pi		=math.pi
	local cos		=math.cos
	local sin		=math.sin
	local acos		=math.acos
	local asin		=math.asin
	local atan2		=math.atan2
	local random	=math.random
	local v3		=Vector3.new
	local nv		=Vector3.new()

	vector.identity=nv
	vector.new=v3
	vector.lerp=nv.lerp
	vector.cross=nv.Cross
	vector.dot=nv.Dot

	function vector.random(a,b)
		local p		=acos(1-2*random())/3
		local z		=3^0.5*sin(p)-cos(p)
		local r		=((1-z*z)*random())^0.5
		local t		=6.28318*random()
		local x		=r*cos(t)
		local y		=r*sin(t)
		if b then
			local m	=(a+(b-a)*random())/(x*x+y*y+z*z)^0.5
			return	v3(m*x,m*y,m*z)
		elseif a then
			return	v3(a*x,a*y,a*z)
		else
			return	v3(x,y,z)
		end
	end

	function vector.anglesyx(x,y)
		local cx=cos(x)
		return v3(-cx*sin(y),sin(x),-cx*cos(y))
	end

	function vector.toanglesyx(v)
		local x,y,z=v.x,v.y,v.z
		return asin(y/(x*x+y*y+z*z)^0.5),atan2(-x,-z)
	end

	function vector.slerp(v0,v1,t)
		local x0,y0,z0		=v0.x,v0.y,v0.z
		local x1,y1,z1		=v1.x,v1.y,v1.z
		local m0			=(x0*x0+y0*y0+z0*z0)^0.5
		local m1			=(x1*x1+y1*y1+z1*z1)^0.5
		local co			=(x0*x1+y0*y1+z0*z1)/(m0*m1)
		if co<-0.99999 then
			local px,py,pz	=0,0,0
			local x2,y2,z2	=x0*x0,y0*y0,z0*z0
			if x2<y2 then
				if x2<z2 then
					px		=1
				else
					pz		=1
				end
			else
				if y2<z2 then
					py		=1
				else
					pz		=1
				end
			end
			local th		=acos((x0*px+y0*py+z0*pz)/m0)
			local r			=pi/th*t
			local s			=((1-t)*m0+t*m1)/sin(th)
			local s0		=s/m0*sin((1-r)*th)
			local s1		=s/m1*sin(r*th)
			return			v3(
				s0*x0+s1*px,
				s0*y0+s1*py,
				s0*z0+s1*pz
			)
		elseif co<0.99999 then
			local th		=acos(co)
			local s			=((1-t)*m0+t*m1)/(1-co*co)^0.5
			local s0		=s/m0*sin((1-t)*th)
			local s1		=s/m1*sin(t*th)
			return			v3(
				s0*x0+s1*x1,
				s0*y0+s1*y1,
				s0*z0+s1*z1
			)
		elseif 1e-5<m0 or 1e-5<m1 then
			if m0<m1 then
				return		((1-t)*m0/m1+t)*v1
			else
				return		((1-t)+t*m1/m0)*v0
			end
		else
			return			nv
		end
	end

end
















--cframe module
--By AxisAngle (Trey Reynolds)
print("Loading cframe module")
do
	local pi			=math.pi
	local halfpi		=pi/2
	local cos			=math.cos
	local sin			=math.sin
	local acos			=math.acos
	local v3			=Vector3.new
	local nv			=v3()
	local cf			=CFrame.new
	local nc			=cf()
	local components	=nc.components
	local tos			=nc.toObjectSpace
	local vtos			=nc.vectorToObjectSpace
	local ptos			=nc.pointToObjectSpace
	local backcf		=cf(0,0,0,-1,0,0,0,1,0,0,0,-1)
	local lerp			=nc.lerp

	cframe.identity		=nc
	cframe.new			=cf
	cframe.vtws			=nc.vectorToWorldSpace
	cframe.tos			=nc.toObjectSpace
	cframe.ptos			=nc.pointToObjectSpace
	cframe.vtos			=nc.vectorToObjectSpace


	function cframe.fromaxisangle(x,y,z)
		if not y then
			x,y,z=x.x,x.y,x.z
		end
		local m=(x*x+y*y+z*z)^0.5
		if m>1e-5 then
			local si=sin(m/2)/m
			return cf(0,0,0,si*x,si*y,si*z,cos(m/2))
		else
			return nc
		end
	end

	function cframe.toaxisangle(c)
		local _,_,_,
		xx,yx,zx,
		xy,yy,zy,
		xz,yz,zz=components(c)
		local co=(xx+yy+zz-1)/2
		if co<-0.99999 then
			local x=xx+yx+zx+1
			local y=xy+yy+zy+1
			local z=xz+yz+zz+1
			local m=pi*(x*x+y*y+z*z)^-0.5
			return v3(m*x,m*y,m*z)
		elseif co<0.99999 then
			local x=yz-zy
			local y=zx-xz
			local z=xy-yx
			local m=acos(co)*(x*x+y*y+z*z)^-0.5
			return v3(m*x,m*y,m*z)
		else
			return nv
		end
	end

	function cframe.direct(c,look,newdir,t)
		local lx,ly,lz		=look.x,look.y,look.z
		local rv			=vtos(c,newdir)
		local rx,ry,rz		=rv.x,rv.y,rv.z
		local rl			=((rx*rx+ry*ry+rz*rz)*(lx*lx+ly*ly+lz*lz))^0.5
		local d				=(lx*rx+ly*ry+lz*rz)/rl
		if d<-0.99999 then
			return c*backcf
		elseif d<0.99999 then
			if t then
				local th	=t*acos(d)/2
				local qw	=cos(th)
				local m		=rl*((1-d*d)/(1-qw*qw))^0.5
				return		c*cf(
					0,0,0,
					(ly*rz-lz*ry)/m,
					(lz*rx-lx*rz)/m,
					(lx*ry-ly*rx)/m,
					qw
				)
			else
				local qw	=((d+1)/2)^0.5
				local m		=2*qw*rl
				return		c*cf(
					0,0,0,
					(ly*rz-lz*ry)/m,
					(lz*rx-lx*rz)/m,
					(lx*ry-ly*rx)/m,
					qw
				)
			end
		else
			return			c
		end
	end

	function cframe.toquaternion(c)
		local x,y,z,
		xx,yx,zx,
		xy,yy,zy,
		xz,yz,zz	=components(c)
		local tr		=xx+yy+zz
		if tr>2.99999 then
			return		x,y,z,0,0,0,1
		elseif tr>-0.99999 then
			local m		=2*(tr+1)^0.5
			return		x,y,z,
				(yz-zy)/m,
				(zx-xz)/m,
				(xy-yx)/m,
				m/4
		else
			local qx	=xx+yx+zx+1
			local qy	=xy+yy+zy+1
			local qz	=xz+yz+zz+1
			local m		=(qx*qx+qy*qy+qz*qz)^0.5
			return		x,y,z,qx/m,qy/m,qz/m,0
		end
	end

	function cframe.power(c,t)
		return lerp(nc,c,t)
	end
	cframe.interpolate=lerp

	--local toquaternion=cframe.toquaternion
	function cframe.interpolator(c0,c1,c2)
		if c2 then
			return function(t)
				return lerp(lerp(c0,c1,t),lerp(c1,c2,t),t)
			end
		elseif c1 then
			return function(t)
				return lerp(c0,c1,t)
			end
		else
			return function(t)
				return lerp(nc,c0,t)
			end
		end
	end

	function cframe.jointleg(r0,r1,c,p,a)
		local t=ptos(c,p)
		local tx,ty,tz=t.x,t.y,t.z

		--Calculate inverse kinemetics equation
		local d=(tx*tx+ty*ty+tz*tz)^0.5
		local nx,ny,nz=tx/d,ty/d,tz/d
		d=r0+r1<d and r0+r1 or d
		local l=(r1*r1-r0*r0-d*d)/(2*r0*d)
		local h=-(1-l*l)^0.5

		--Generate the natural quaternion for the shoulder.
		local m=(2*(1+h*ny+l*nz))^0.5
		local qw,qx,qy,qz=m/2,(h*nz-l*ny)/m,l*nx/m,-h*nx/m

		--If a, then rotate the natural quaternion by a.
		if a then
			local co,si=cos(a/2),sin(a/2)
			qw,qx,qy,qz=co*qw-si*(nx*qx+ny*qy+nz*qz),
				co*qx+si*(nx*qw-nz*qy+ny*qz),
				co*qy+si*(ny*qw+nz*qx-nx*qz),
				co*qz+si*(nz*qw-ny*qx+nx*qy)
		end

		--Generate the quaternion for the lower arm and return.
		local g=(d*l+r0)/(d*d+2*d*l*r0+r0*r0)^0.5
		local co=((1-g)/2)^0.5
		local si=-((1+g)/2)^0.5
		return c*cf(-r0*2*(qx*qz+qy*qw),
			r0*2*(qx*qw-qy*qz),
			r0*(2*(qx*qx+qy*qy)-1),
			co*qx+si*qw,
			co*qy+si*qz,
			co*qz-si*qy,
			co*qw-si*qx),
			c*cf(0,0,0,qx,qy,qz,qw)
	end

	function cframe.jointarm(r0,r1,c,p,a)
		local t=ptos(c,p)
		local tx,ty,tz=t.x,t.y,t.z

		--Calculate inverse kinemetics equation
		local d=(tx*tx+ty*ty+tz*tz)^0.5
		local nx,ny,nz=tx/d,ty/d,tz/d
		d=r0+r1<d and r0+r1 or d
		local l=(r1*r1-r0*r0-d*d)/(2*r0*d)
		local h=(1-l*l)^0.5

		--Generate the natural quaternion for the shoulder.
		local m=(2*(1+h*ny+l*nz))^0.5
		local qw,qx,qy,qz=m/2,(h*nz-l*ny)/m,l*nx/m,-h*nx/m

		--If a, then rotate the natural quaternion by a.
		if a then
			local co,si=cos(a/2),sin(a/2)
			qw,qx,qy,qz=co*qw-si*(nx*qx+ny*qy+nz*qz),
				co*qx+si*(nx*qw-nz*qy+ny*qz),
				co*qy+si*(ny*qw+nz*qx-nx*qz),
				co*qz+si*(nz*qw-ny*qx+nx*qy)
		end

		--Generate the quaternion for the lower arm and return.
		local g=(d*l+r0)/(d*d+2*d*l*r0+r0*r0)^0.5
		local co=((1-g)/2)^0.5
		local si=((1+g)/2)^0.5
		return c*cf(-r0*2*(qx*qz+qy*qw),
			r0*2*(qx*qw-qy*qz),
			r0*(2*(qx*qx+qy*qy)-1),
			co*qx+si*qw,
			co*qy+si*qz,
			co*qz-si*qy,
			co*qw-si*qx),
			c*cf(0,0,0,qx,qy,qz,qw)
	end
end


















--network module
--By AxisAngle (Trey Reynolds)
print("Loading network module")
do
	function network:add(thread,fn)
		network[thread]=fn;
	end
	function network:bounce(thread,...)
		self[thread](...);
	end
end








--event module
--By AxisAngle (Trey Reynolds)
print("Loading event module")
do
	function event.new(eventtable)
		local self=eventtable or {}

		local removelist		={}
		local functions			={}
		local pendingdeletion	=false

		function self:Connect(func)
			functions[#functions+1]=func

			return function()
				removelist[func]=true
				pendingdeletion=true
			end
		end

		return function(...)
			if pendingdeletion then
				pendingdeletion=false
				local j=1
				for i=1,#functions do
					local f=functions[i]
					functions[i]=nil
					if removelist[f] then
						removelist[f]=nil
					else
						f(...)
						functions[j]=f
						j=j+1
					end
				end
			else
				for i=1,#functions do
					if functions[i] then
						functions[i](...)
					else
						print("AHHHHHH",i)
					end
				end
			end
		end,
			self
	end
end
















--sequencer module
--By AxisAngle (Trey Reynolds)
print("Loading sequencer module")
do
	local tick		=tick
	local type		=type
	local remove	=table.remove

	function sequencer.new()
		local self={}

		local t0
		local sequence	={}
		local n			=0
		local deletions	=0

		function self:add(func,dur)
			--print("added",func)
			n=n+1
			if n==1 then
				t0=tick()
			end
			sequence[n]={
				func=func;
				dur=dur;
			}
		end

		function self:delay(dur)
			--print("delaying",dur)
			n=n+1
			if n==1 then
				t0=tick()
			end
			sequence[n]={
				dur=dur;
			}
		end

		function self:clear()
			--print("cleared")
			for i=1,n do
				sequence[i]=nil
			end
			deletions=0
			n=0
		end

		function self:step()
			--print(unpack(sequence))
			local time=tick()
			if deletions~=0 then
				for i=deletions+1,n do
					sequence[i-deletions]=sequence[i]
				end
				for i=n-deletions+1,n do
					sequence[i]=nil
				end
				n=n-deletions
				deletions=0
			end
			for i=1,n do
				local t=time-t0
				local func=sequence[i]
				local dur=func.dur
				local stop=false
				if func.func then
					stop=func.func(t)
				end
				if stop or stop==nil or dur and dur<t then
					t0=time
					deletions=deletions+1
				else
					break
				end
			end
		end

		return self
	end
end
















--physics module
--By AxisAngle (Trey Reynolds)
print("Loading physics module")
do
	local sort			=table.sort
	local atan2			=math.atan2
	local inf			=math.huge
	local cos			=math.cos
	local sin			=math.sin
	local setmetatable	=setmetatable
	local tick			=tick
	local dot			=Vector3.new().Dot

	physics.spring		={}

	do
		local cos=math.cos
		local sin=math.sin
		local e=2.718281828459045
		local setmt=setmetatable
		local error=error
		local tostring=tostring
		local tick=tick

		local function posvel(d,s,p0,v0,p1,v1,x)
			if s==0 then
				return p0
			elseif d<1-1e-8 then
				local h=(1-d*d)^0.5
				local c1=(p0-p1+2*d/s*v1)
				local c2=d/h*(p0-p1)+v0/(h*s)+(2*d*d-1)/(h*s)*v1
				local co=cos(h*s*x)
				local si=sin(h*s*x)
				local ex=e^(d*s*x)
				return co/ex*c1+si/ex*c2+p1+(x-2*d/s)*v1,
					s*(co*h-d*si)/ex*c2-s*(co*d+h*si)/ex*c1+v1
			elseif d<1+1e-8 then
				local c1=p0-p1+2/s*v1
				local c2=p0-p1+(v0+v1)/s
				local ex=e^(s*x)
				return (c1+c2*s*x)/ex+p1+(x-2/s)*v1,
					v1-s/ex*(c1+(s*x-1)*c2)
			else
				local h=(d*d-1)^0.5
				local a=(v1-v0)/(2*s*h)
				local b=d/s*v1-(p1-p0)/2
				local c1=(1-d/h)*b+a
				local c2=(1+d/h)*b-a
				local co=e^(-(h+d)*s*x)
				local si=e^((h-d)*s*x)
				return c1*co+c2*si+p1+(x-2*d/s)*v1,
					si*(h-d)*s*c2-co*(d+h)*s*c1+v1
			end
		end

		local function targposvel(p1,v1,x)
			return p1+x*v1,v1
		end

		function physics.spring.new(initial)
			local d=1
			local s=1
			local p0=initial or 0
			local v0=0*p0
			local p1=p0
			local v1=v0
			local t0=tick()

			local self={}
			local meta={}

			function self.getpv()
				return posvel(d,s,p0,v0,p1,v1,tick()-t0)
			end

			function self.setpv(p,v)
				local time=tick()
				local tp,tv=targposvel(p1,v1,time-t0)
				p0,v0=p,v
				p1,v1=tp,tv
				t0=time
			end

			function self.settargetpv(tp,tv)
				local time=tick()
				local p,v=posvel(d,s,p0,v0,p1,v1,time-t0)
				p0,v0=p,v
				p1,v1=tp,tv
				t0=time
			end

			function self:accelerate(a)
				local time=tick()
				local p,v=posvel(d,s,p0,v0,p1,v1,time-t0)
				local tp,tv=targposvel(p1,v1,time-t0)
				p0,v0=p,v+a
				p1,v1=tp,tv
				t0=time
			end

			function meta.__index(self,index)
				local time=tick()
				if index=="p" or index=="position" then
					local p,v=posvel(d,s,p0,v0,p1,v1,time-t0)
					return p
				elseif index=="v" or index=="velocity" then
					local p,v=posvel(d,s,p0,v0,p1,v1,time-t0)
					return v
				elseif index=="tp" or index=="t" or index=="targetposition" then
					local tp,tv=targposvel(p1,v1,time-t0)
					return tp
				elseif index=="tv" or index=="targetvelocity" then
					local tp,tv=targposvel(p1,v1,time-t0)
					return tv
				elseif index=="d" or index=="damper" then
					return d
				elseif index=="s" or index=="speed" then
					return s
				else
					error("no value "..tostring(index).." exists")
				end
			end

			function meta.__newindex(self,index,value)
				local time=tick()
				if index=="p" or index=="position" then
					local p,v=posvel(d,s,p0,v0,p1,v1,time-t0)
					local tp,tv=targposvel(p1,v1,time-t0)
					p0,v0=value,v
					p1,v1=tp,tv
				elseif index=="v" or index=="velocity" then
					local p,v=posvel(d,s,p0,v0,p1,v1,time-t0)
					local tp,tv=targposvel(p1,v1,time-t0)
					p0,v0=p,value
					p1,v1=tp,tv
				elseif index=="tp" or index=="t" or index=="targetposition" then
					local p,v=posvel(d,s,p0,v0,p1,v1,time-t0)
					local tp,tv=targposvel(p1,v1,time-t0)
					p0,v0=p,v
					p1,v1=value,tv
				elseif index=="tv" or index=="targetvelocity" then
					local p,v=posvel(d,s,p0,v0,p1,v1,time-t0)
					local tp,tv=targposvel(p1,v1,time-t0)
					p0,v0=p,v
					p1,v1=tp,value
				elseif index=="d" or index=="damper" then
					local p,v=posvel(d,s,p0,v0,p1,v1,time-t0)
					local tp,tv=targposvel(p1,v1,time-t0)
					p0,v0=p,v
					p1,v1=tp,tv
					d=value
				elseif index=="s" or index=="speed" then
					local p,v=posvel(d,s,p0,v0,p1,v1,time-t0)
					local tp,tv=targposvel(p1,v1,time-t0)
					p0,v0=p,v
					p1,v1=tp,tv
					s=value
				elseif index=="a" or index=="acceleration" then
					local time=tick()
					local p,v=posvel(d,s,p0,v0,p1,v1,time-t0)
					local tp,tv=targposvel(p1,v1,time-t0)
					p0,v0=p,v+value
					p1,v1=tp,tv
					t0=time
				else
					error("no value "..tostring(index).." exists")
				end
				t0=time
			end

			return setmt(self,meta)
		end
	end

	local function rootreals4(a,b,c,d,e)
		local x0,x1,x2,x3
		local m10=3*a
		local m0=-b/(4*a)
		local m4=c*c-3*b*d+12*a*e
		local m6=(b*b/(4*a)-2/3*c)/a
		local m9=((b*(4*c-b*b/a))/a-(8*d))/a
		local m5=c*(2*c*c-9*b*d-72*a*e)+27*a*d*d+27*b*b*e
		local m11=m5*m5-4*m4*m4*m4
		local m7
		if m11<0 then--Optimize
			local th=atan2((-m11)^0.5,m5)/3
			local m=((m5*m5-m11)/4)^(1/6)
			m7=(m4/m+m)/m10*cos(th)
		else--MAY NEED CASE FOR WHEN 2*c*c*c-9*b*c*d+27*a*d*d+27*b*b*e-72*a*c*e+((2*c*c*c-9*b*c*d+27*a*d*d+27*b*b*e-72*a*c*e)^2-4*(c*c-3*b*d+12*a*e)^3)^(1/2)=0
			local m8=(m5+m11^0.5)/2
			m8=m8<0 and -(-m8)^(1/3) or m8^(1/3)
			m7=(m4/m8+m8)/m10
		end
		local m2=2*m6-m7
		--print("m2",m2,0)
		local m12=m6+m7
		if m12<0 then
			local m3i=m9/(4*(-m12)^0.5)
			local m13=(m3i*m3i+m2*m2)^(1/4)*cos(atan2(m3i,m2)/2)/2
			--In order
			x0=m0-m13
			x1=m0-m13
			x2=m0+m13
			x3=m0+m13
		else
			local m1=m12^0.5
			--print("m1",m1,0)
			local m3=m9/(4*m1)
			--print("m3",m3,0)
			local m14=m2-m3
			local m15=m2+m3
			if m14<0 then
				x0=m0-m1/2
				x1=m0-m1/2
			else
				local m16=m14^0.5
				x0=m0-(m1+m16)/2
				x1=m0-(m1-m16)/2
			end
			if m15<0 then
				x2=m0+m1/2
				x3=m0+m1/2
			else
				local m17=m15^0.5
				x2=m0+(m1-m17)/2
				x3=m0+(m1+m17)/2
			end
			--bubble sort lel
			if x1<x0 then x0,x1=x1,x0 end
			if x2<x1 then x1,x2=x2,x1 end
			if x3<x2 then x2,x3=x3,x2 end
			if x1<x0 then x0,x1=x1,x0 end
			if x2<x1 then x1,x2=x2,x1 end
			if x1<x0 then x0,x1=x1,x0 end
		end
		return x0,x1,x2,x3
	end

	local function rootreals3(a,b,c,d)
		local x0,x1,x2
		local d0=b*b-3*a*c
		local d1=2*b*b*b+27*a*a*d-9*a*b*c
		local d=d1*d1-4*d0*d0*d0
		local m0=-1/(3*a)
		if d<0 then
			local cr,ci=d1/2,(-d)^0.5/2
			local th=atan2(ci,cr)/3
			local m=(cr*cr+ci*ci)^(1/6)
			local cr,ci=m*cos(th),m*sin(th)
			local m1=(1+d0/(m*m))/2
			local m2=(cr*d0+(cr-2*b)*m*m)/(6*a*m*m)
			local m3=ci*(d0+m*m)/(2*3^0.5*a*m*m)
			x0=-(b+cr*(1+d0/(m*m)))/(3*a)
			x1=m2-m3
			x2=m2+m3
		else
			local c3=(d1+d^0.5)/2
			c=c3<0 and -(-c3)^(1/3) or c3^(1/3)
			x0=m0*(b+c+d0/c)
			x1=m0*(b-(c*c+d0)/(2*c))
			x2=x1
		end
		if x1<x0 then x0,x1=x1,x0 end
		if x2<x1 then x1,x2=x2,x1 end
		if x1<x0 then x0,x1=x1,x0 end
		return x0,x1,x2
	end

	local function rootreals2(a,b,c)
		local p=-b/(2*a)
		local q2=p*p-c/a
		if 0<q2 then
			local q=q2^0.5
			return p-q,p+q
		else
			return p,p
		end
	end

	local solvemoar

	local function solve(a,b,c,d,e)
		if a*a<1e-32 then
			return solve(b,c,d,e)
		elseif e then
			if e*e<1e-32 then
				return solvemoar(a,b,c,d)
			elseif b*b<1e-12 and d*d<1e-12 then
				local roots={}
				local found={}
				local r0,r1=solve(a,c,e)
				if r0 then
					if r0>0 then
						local x=r0^0.5
						roots[#roots+1]=-x
						roots[#roots+1]=x
					elseif r0*r0<1e-32 then
						roots[#roots+1]=0
					end
				end
				if r1 then
					if r1>0 then
						local x=r1^0.5
						roots[#roots+1]=-x
						roots[#roots+1]=x
					elseif r1*r1<1e-32 then
						roots[#roots+1]=0
					end
				end
				sort(roots)
				return unpack(roots)
			else
				local roots={}
				local found={}
				local x0,x1,x2,x3=rootreals4(a,b,c,d,e)
				local d0,d1,d2=rootreals3(4*a,3*b,2*c,d)
				local m0,m1,m2,m3,m4=-inf,d0,d1,d2,inf
				local l0,l1,l2,l3,l4=a*inf,(((a*d0+b)*d0+c)*d0+d)*d0+e,(((a*d1+b)*d1+c)*d1+d)*d1+e,(((a*d2+b)*d2+c)*d2+d)*d2+e,a*inf
				if (l0<=0)==(0<=l1) then
					roots[#roots+1]=x0
					found[x0]=true
				end
				if (l1<=0)==(0<=l2) and not found[x1] then
					roots[#roots+1]=x1
					found[x1]=true
				end
				if (l2<=0)==(0<=l3) and not found[x2] then
					roots[#roots+1]=x2
					found[x2]=true
				end
				if (l3<=0)==(0<=l4) and not found[x3] then
					roots[#roots+1]=x3
				end
				return unpack(roots)
			end
		elseif d then
			if d*d<1e-32 then
				return solvemoar(a,b,c)
			elseif b*b<1e-12 and c*c<1e-12 then
				local p=d/a
				return p<0 and (-p)^(1/3) or -p^(1/3)
			else
				local roots={}
				local found={}
				local x0,x1,x2=rootreals3(a,b,c,d)
				local d0,d1=rootreals2(3*a,2*b,c)
				local l0,l1,l2,l3=-a*inf,((a*d0+b)*d0+c)*d0+d,((a*d1+b)*d1+c)*d1+d,a*inf
				if (l0<=0)==(0<=l1) then
					roots[#roots+1]=x0
					found[x0]=true
				end
				if (l1<=0)==(0<=l2) and not found[x1] then
					roots[#roots+1]=x1
					found[x1]=true
				end
				if (l2<=0)==(0<=l3) and not found[x2] then
					roots[#roots+1]=x2
				end
				return unpack(roots)
			end
		elseif c then
			local p=-b/(2*a)
			local q2=p*p-c/a
			if 0<q2 then
				local q=q2^0.5
				return p-q,p+q
			elseif q2==0 then
				return p
			end
		elseif b then
			if a*a>1e-32 then
				return -b/a
			end
		end
	end

	function solvemoar(a,b,c,d,e)
		local roots={solve(a,b,c,d,e)}
		local good=true
		for i=1,#roots do
			if roots[i]==0 then
				good=false
				break
			end
		end
		if good then
			roots[#roots+1]=0
			sort(roots)
		end
		return unpack(roots)
	end

	function physics.trajectory(pp,pv,pa,tp,tv,ta,s)
		local rp=tp-pp
		local rv=tv-pv
		local ra=ta-pa
		local t0,t1,t2,t3=solve(
			dot(ra,ra)/4,
			dot(ra,rv),
			dot(ra,rp)+dot(rv,rv)-s*s,
			2*dot(rp,rv),
			dot(rp,rp)
		)
		if t0 and t0>0 then
			return ra*t0/2+tv+rp/t0,t0
		elseif t1 and t1>0 then
			return ra*t1/2+tv+rp/t1,t1
		elseif t2 and t2>0 then
			return ra*t2/2+tv+rp/t2,t2
		elseif t3 and t3>0 then
			return ra*t3/2+tv+rp/t3,t3
		end
	end
end









--tween module
--By AxisAngle (Trey Reynolds)
print("Loading tween module")
do
	local type			=type
	local halfpi		=math.pi/2
	local acos			=math.acos
	local sin			=math.sin
	local cf			=CFrame.new
	local tos			=cf().toObjectSpace
	local components	=cf().components
	local tick			=tick

	local tweendata		={}
	local equations		={
		linear			={p0=0;v0=1;p1=1;v1=1};
		smooth			={p0=0;v0=0;p1=1;v1=0};
		accelerate		={p0=0;v0=0;p1=1;v1=1};
		decelerate		={p0=0;v0=1;p1=1;v1=0};
		bump			={p0=0;v0=4;p1=0;v1=-4};
		acceleratebump	={p0=0;v0=0;p1=0;v1=-6.75};
		deceleratebump	={p0=0;v0=6.75;p1=0;v1=0};
	}

	local updater		={}
	tween.step			=event.new(updater)

	function tween.tweencframe(object,index,time,equation,nextcframe)
		if tweendata[object] then
			tweendata[object]()
		end
		local t0=tick()
		local p0,v0,p1,v1
		if type(equation)=="table" then
			p0=equation[1]
			v0=equation[2]
			p1=equation[3]
			v1=equation[4]
		else
			local eq=equations[equation]
			p0,v0,p1,v1=eq.p0,eq.v0,eq.p1,eq.v1
		end
		local interpolator=cframe.interpolator(object[index],nextcframe)
		local stop;stop=updater:Connect(function()
			local u=(tick()-t0)/time
			if u>1 then
				object[index]=interpolator(p1)
				stop()
				tweendata[object]=nil
			else
				local v=1-u
				local t=p0*v*v*v+(3*p0+v0)*u*v*v+(3*p1-v1)*u*u*v+p1*u*u*u
				object[index]=interpolator(t)
			end
		end)
		tweendata[object]=stop
		return stop
	end

	function tween.freebody(object,index,life,cframe0,velocity0,rotation0,acceleration)
		local position0=cframe0.p
		local matrix0=cframe0-position0
		local tick0=tick()
		local stop;stop=updater:Connect(function()
			local t=tick()-tick0
			if life and t>life then
				stop()
				--trash.remove(object)
			end
			object[index]=cframe.fromaxisangle(t*rotation0)*matrix0+position0+t*velocity0+t*t*acceleration
		end)
		return stop
	end
end
















--input module
--By AxisAngle (Trey Reynolds)
print("Loading input module")
do
	local tick						=tick
	local lower						=string.lower
	local nv						=Vector3.new()
	local userinput					=game:GetService("UserInputService")

	local abbreviation				={
		ButtonX			="x";
		ButtonY			="y";
		ButtonA			="a";
		ButtonB			="b";
		ButtonR1		="r1";
		ButtonL1		="l1";
		ButtonR2		="r2";
		ButtonL2		="l2";
		ButtonR3		="r3";
		ButtonL3		="l3";
		ButtonStart		="start";
		ButtonSelect	="select";
		DPadLeft		="left";
		DPadRight		="right";
		DPadUp			="up";
		DPadDown		="down";
	}

	input.keyboard					={}
	input.keyboard.down				={}
	input.keyboard.onkeydown		={}
	input.keyboard.onkeyup			={}
	input.mouse						={}
	input.mouse.Position			=nv
	input.mouse.down				={}
	input.mouse.onbuttondown		={}
	input.mouse.onbuttonup			={}
	input.mouse.onmousemove			={}
	input.mouse.onscroll			={}
	input.controller				={}
	input.controller.down			={}
	input.controller.onbuttondown	={}
	input.controller.onbuttonup		={}
	input.controller.onintegralmove	={}
	input.consoleon					=not userinput.KeyboardEnabled
	---con test

	local fireonkeydown				=event.new(input.keyboard.onkeydown)
	local fireonkeyup				=event.new(input.keyboard.onkeyup)
	local fireonbuttondown			=event.new(input.mouse.onbuttondown)
	local fireonbuttonup			=event.new(input.mouse.onbuttonup)
	local fireonmousemove			=event.new(input.mouse.onmousemove)
	local fireonscroll				=event.new(input.mouse.onscroll)
	local fireoncbuttondown			=event.new(input.controller.onbuttondown)
	local fireoncbuttonup			=event.new(input.controller.onbuttonup)
	local fireonintegralmove		=event.new(input.controller.onintegralmove)

	local keymap					={}
	local triggerthreshold			=0.2
	local stickthreshold			=0.25--lol
	local gamepadpos
	local triggeron					={}

	local typing

	userinput.TextBoxFocused:Connect(function()
		typing=true
	end)

	userinput.TextBoxFocusReleased:Connect(function()
		typing=false
	end)

	userinput.InputChanged:Connect(function(object)
		local type=object.UserInputType.Name
		local pos=object.Position
		if type=="MouseMovement" then
			input.mouse.position=pos
			fireonmousemove(object.Delta)
		elseif type=="MouseWheel" then
			fireonscroll(pos.z)
		elseif type=="Gamepad1" then
			local key=object.KeyCode.Name
			--Thumbstick1 reserved for movement
			if key=="Thumbstick2" then
				local m=pos.magnitude
				if stickthreshold<m then
					gamepadpos=(1-stickthreshold/m)/(1-stickthreshold)*pos
				elseif gamepadpos then
					gamepadpos=nil
				end
			elseif (key=="ButtonL2" or key=="ButtonR2") then
				local abv=abbreviation[key]
				if triggerthreshold<pos.z and not input.controller.down[abv] then 
					local mappedkey=keymap[abv]
					if mappedkey then
						input.keyboard.down[mappedkey]=tick()
						fireonkeydown(mappedkey)
					end
					input.controller.down[abv]=tick()
					fireoncbuttondown(abv)
				elseif pos.z<triggerthreshold and input.controller.down[abv] then
					local mappedkey=keymap[abv]
					if mappedkey then
						input.keyboard.down[mappedkey]=nil
						fireonkeyup(mappedkey)
					end
					input.controller.down[abv]=nil
					fireoncbuttonup(abv)
				end
			end
		end
	end)

	userinput.InputBegan:Connect(function(object)
		local type=object.UserInputType.Name
		if type=="Keyboard" then
			local key=lower(object.KeyCode.Name)
			input.keyboard.down[key]=tick()
			fireonkeydown(key)
		elseif type=="Gamepad1" then
			local key=abbreviation[object.KeyCode.Name]
			if key and key~="l2" and key~="r2" or not input.controller.down[key] then
				local mappedkey=keymap[key]
				if mappedkey then
					input.keyboard.down[mappedkey]=tick()
					fireonkeydown(mappedkey)
				end
				input.controller.down[key]=tick()
				fireoncbuttondown(key)
			end
		elseif type=="MouseButton1" then
			input.mouse.down.left=tick()
			fireonbuttondown("left")
		elseif type=="MouseButton2" then
			input.mouse.down.right=tick()
			fireonbuttondown("right")
		elseif type=="MouseButton3" then
			input.mouse.down.middle=tick()
			fireonbuttondown("middle")
		end
	end)

	userinput.InputEnded:Connect(function(object)
		if typing then return end
		local type=object.UserInputType.Name
		if type=="Keyboard" then
			local key=lower(object.KeyCode.Name)
			input.keyboard.down[key]=nil
			fireonkeyup(key)
		elseif type=="Gamepad1" then
			local key=abbreviation[object.KeyCode.Name]
			if key and key~="l2" and key~="r2" or input.controller.down[key] then
				local mappedkey=keymap[key]
				if mappedkey then
					input.keyboard.down[mappedkey]=nil
					fireonkeyup(mappedkey)
				end
				input.controller.down[key]=nil
				fireoncbuttonup(key)
			end
		elseif type=="MouseButton1" then
			input.mouse.down.left=nil
			fireonbuttonup("left")
		elseif type=="MouseButton2" then
			input.mouse.down.right=nil
			fireonbuttonup("right")
		elseif type=="MouseButton3" then
			input.mouse.down.middle=nil
			fireonbuttonup("middle")
		end
	end)

	function input.mouse:hide()
		userinput.MouseIconEnabled=false
	end

	function input.mouse:show()
		userinput.MouseIconEnabled=true
	end

	function input.mouse.visible()
		return userinput.MouseIconEnabled
	end

	function input.mouse:lockcenter()
		userinput.MouseBehavior="LockCenter"
	end

	function input.mouse:free()
		userinput.MouseBehavior="Default"
	end

	function input.mouse:lock()
		userinput.MouseBehavior="LockCurrentPosition"
	end

	function input.controller:map(button,key)
		keymap[button]=key
	end

	function input.controller:unmap(button)
		keymap[button]=nil
	end

	function input.step(dt)
		if gamepadpos then
			fireonintegralmove(dt*gamepadpos,dt)
		end
	end
end








do
	local rtype			=game.IsA
	local next			=next
	local new			=Instance.new
	local wfc			=game.WaitForChild
	local ffc			=game.FindFirstChild
	local getchildren	=game.GetChildren
	local workspace		=game.Workspace
	local cf			=CFrame.new
	local vtws			=CFrame.new().vectorToWorldSpace
	local angles		=CFrame.Angles
	local nc			=cf()
	local v3			=Vector3.new
	local nv			=v3()
	local ray			=Ray.new
	local raycast		=workspace.FindPartOnRayWithIgnoreList
	local debris		=game.Debris
	local dot			=nv.Dot
	local ud2			=UDim2.new
	local abs			=math.abs
	local tos			=cf().toObjectSpace
	
	local direct = cframe.direct
	
	local player		=game.Players.LocalPlayer
	local pgui			=player.PlayerGui
	local repstore		=game.ReplicatedStorage
	local character
	local humanoid
	local rootpart
	local rootjoint
	local statsloaded


	local thread			=sequencer.new()
	local weapon			=nil
	local aiming			=false
	local auto				=false
	local burst				=0
	local reloading			=false
	local sprinting			=false
	local animating			=false
	local stability			=0
	local basewalkspeed		=14
	local sprintspring		=physics.spring.new()
	local climbing             =physics.spring.new()
	local aimspring			=physics.spring.new()
	local swingspring		=physics.spring.new(nv)
	local speedspring		=physics.spring.new()
	local velocityspring	=physics.spring.new(nv)
	local pronespring		=physics.spring.new(0)
	local truespeedspring	=physics.spring.new(0)
	local equipspring		=physics.spring.new(1)
	local muzzlespring		=physics.spring.new(0)
	local walkspeedmult		=1

	sprintspring.s			=12
	sprintspring.d			=0.9
	climbing.s                  =12
	climbing.d                  =0.9
	aimspring.d				=0.9
	swingspring.s			=10
	swingspring.d			=0.75
	speedspring.s			=16
	velocityspring.s		=16
	pronespring.s			=8
	truespeedspring.s		=8
	equipspring.s			=12
	equipspring.d			=0.75



	local ignore			={game.Workspace.CurrentCamera}
	local backwardsmult = 0.8
	local bodyforce = new("BodyVelocity")
	bodyforce.Name = "\n"
	local muzzlelight, walkspeedspring, headheightspring, updatewalkspeed
	walkspeedspring = physics.spring.new(basewalkspeed)
	walkspeedspring.s = 8
	headheightspring = physics.spring.new(1.5)
	headheightspring.s = 8
	char.acceleration = nv
	bodyforce.MaxForce = nv

	do
		local movementmode	="stand"
		local down			=v3(0,-4,0)
		local standcf		=nc
		local crouchcf		=cf(0,-1.5,0)
		local pronecf		=cf(0,-1.5,1.5,1,0,0,0,0,1,0,-1,0)

		function updatewalkspeed()
			if sprinting then
				walkspeedspring.t=1.4*walkspeedmult*basewalkspeed
			elseif movementmode=="prone" then
				walkspeedspring.t=walkspeedmult*basewalkspeed/4
			elseif movementmode=="crouch" then
				walkspeedspring.t=walkspeedmult*basewalkspeed/2
			elseif movementmode=="stand" then
				walkspeedspring.t=walkspeedmult*basewalkspeed
			end
		end

		local function setmovementmode(self,mode,dive)
			local oldmode = char.movementmode
			char.movementmode=mode
			movementmode=mode
			if mode=="prone" then
				headheightspring.t=-1.5
				rootjoint.C0=pronecf
				pronespring.t=1
				walkspeedspring.t=walkspeedmult*basewalkspeed/4
				stability=0.25
				if dive and sprinting and humanoid:GetState()~=Enum.HumanoidStateType.Freefall then
					spawn(function()
						local lkvector = rootpart.CFrame.lookVector
						rootpart.Velocity = lkvector * (50 * loltimescale) + v3(0, 40 * loltimescale, 0)
						wait(0.1 / loltimescale)
						rootpart.Velocity = lkvector * (60 * loltimescale) + v3(0, 30 * loltimescale, 0)
						wait(0.4 / loltimescale)
						rootpart.Velocity = lkvector * (20 * loltimescale) + v3(0, -10 * loltimescale, 0)
					end)
				end
			elseif mode == "crouch" then
				headheightspring.t = 0
				pronespring.t = 0
				walkspeedspring.t = walkspeedmult * basewalkspeed / 2
				stability = 0.15
				if dive and sprinting and humanoid:GetState() ~= Enum.HumanoidStateType.Freefall then
					isSliding = true
					spawn(function()
						local lkvector = rootpart.CFrame.lookVector
						local released
						bodyforce.MaxForce = v3(40000, 10, 40000)
						for i = 1, 20 do
							if input.keyboard.down.leftshift then
								lkvector = rootpart.CFrame.lookVector
							end
							bodyforce.Velocity = lkvector * (40 * loltimescale - i * 1.5 * loltimescale) + v3(0, 0, 0)
							wait(0.03333333333333333 / loltimescale)
						end
						bodyforce.MaxForce = nv
						if isSliding then
							isSliding = false
						end
					end)
				end
			elseif mode == "stand" then
				if oldmode ~= mode then
				end
				headheightspring.t=1.5
				rootjoint.C0=standcf
				pronespring.t=0
				walkspeedspring.t=walkspeedmult*basewalkspeed
				stability=0
			end
			network:bounce("stance",player,mode)
			sprinting=false
			network:bounce("sprint",player,sprinting)
			sprintspring.t=0
		end
		function char.getstate()
			return humanoid:GetState()
		end
		function char:sprinting()
			return sprinting
		end

		char.setmovementmode=setmovementmode

		function char:setbasewalkspeed(newspeed)
			basewalkspeed=newspeed
			updatewalkspeed()
		end

		function char:setsprint(on)
			if on then
				setmovementmode(nil,"stand")
				sprinting=true
				network:bounce("sprint",player,sprinting)
				auto=false
				burst=0
				if weapon and aiming and weapon.type~="KNIFE" then
					weapon:setaim(false)
				end
				walkspeedmult=1
				if not reloading and not animating then
					sprintspring.t=1
				end
				walkspeedspring.t=1.5*walkspeedmult*basewalkspeed
			elseif sprinting then
				sprinting=false
				network:bounce("sprint",player,sprinting)
				sprintspring.t=0
				walkspeedspring.t=walkspeedmult*basewalkspeed
			end
		end

		local function parkour()
			if weapon then 
				weapon:playanimation("parkour")
			end
			local bp=new("BodyPosition",rootpart)
			bp.position=rootpart.Position+rootpart.CFrame.lookVector.unit*char.speed/1.5+v3(0,10,0)
			bp.maxForce=v3(5000000, 5000000, 5000000)
			bp.P=4000	
			debris:AddItem(bp,0.45)
		end

		function char:jump(height,numjumps)
			local rootcf=rootpart.CFrame
			if raycast(workspace,ray(rootcf.p,vtws(rootcf,down)),{workspace.CurrentCamera}) then
				if movementmode=="prone" or movementmode=="crouch" then
					setmovementmode(nil,"stand")
				else
					if not reloading and not aiming and not char.grenadehold then
						local r1=ray(rootpart.CFrame.p+v3(0,1.5,0),rootpart.CFrame.lookVector*25+v3(0,2,0))
						local h1,e1=raycast(workspace,r1,{character,camera})

						local r2=ray(rootpart.CFrame.p-v3(0,1,0),(rootpart.CFrame.lookVector)*25-v3(0,1,0))
						local h2,e2=raycast(workspace,r2,{character,camera})

						local r3=ray(rootpart.CFrame.p-v3(0,1.250),(rootpart.CFrame.lookVector)*25-v3(0,1.5,0))
						local h3,e3=raycast(workspace,r3,{character,camera})

						if h3 and (e3-e2).Magnitude<0.7 and (e3-e1).Magnitude>4 and (e3-rootpart.Position).Magnitude<char.speed/1.5 then
							parkour(h3)
						else
							rootpart.Velocity=rootpart.Velocity+v3(0,height and (392.4*height)^0.5 or 40,0)
						end
					else
						rootpart.Velocity=rootpart.Velocity+v3(0,height and (392.4*height)^0.5 or 40,0)
					end		
				end
			end
		end	
	end








	--WEAPONS MODULE LEL

	--Add dynamic animation shit
	--Inspection
	--Spotting
	local equipping	=false
	local zooming	=false
	local rweld
	local lweld
	local larm
	local rarm
	local lmodel
	local rmodel
	local lmain
	local rmain
	local sin		=math.sin
	local cos		=math.cos

	char.grenadehold=false	
	local function gunbob(a,r)
		local a,r=a or 1,r or 1
		local d,s,v=char.distance*6.28318*3/4,char.speed,-char.velocity
		local w=v3(r*sin(d/4-1)/256+r*(sin(d/64)-r*v.z/4)/512,r*cos(d/128)/128-r*cos(d/8)/256,r*sin(d/8)/128+r*v.x/1024)*s/20*6.28318
		return cf(r*cos(d/8-1)*s/196,1.25*a*sin(d/4)*s/512,0)*cframe.fromaxisangle(w)
	end

	local function gunsway(a)
		local d,s=tick()*6,2*(1.2-a)
		return cf(cos(d/8)*s/128,-sin(d/4)*s/128,sin(d/16)*s/64)
	end

	local tos = CFrame.new().toObjectSpace

	local clone			=game.Clone
	local currentcamera	=game.Workspace.CurrentCamera
	local ffc			=game.FindFirstChild

	function char:reloadsprings()
		sprintspring			=physics.spring.new()
		aimspring				=physics.spring.new()
		swingspring				=physics.spring.new(nv)
		speedspring				=physics.spring.new()
		velocityspring			=physics.spring.new(nv)
		pronespring				=physics.spring.new(0)
		truespeedspring			=physics.spring.new(0)
		equipspring				=physics.spring.new(1)
		muzzlespring			=physics.spring.new(0)

		equipspring.s			=12
		equipspring.d			=0.75

		sprintspring.s			=12
		sprintspring.d			=0.9
		aimspring.d				=0.9
		swingspring.s			=10
		swingspring.d			=0.75
		speedspring.s			=16
		velocityspring.s		=16
		pronespring.s			=8
		truespeedspring.s		=8

		muzzlespring.s			=50
		muzzlespring.d			=1

		walkspeedspring			=physics.spring.new(basewalkspeed)
		walkspeedspring.s		=8
		headheightspring		=physics.spring.new(1.5)
		headheightspring.s		=8 

		if muzzlelight then
			muzzlelight:Destroy()
		end
		muzzlelight = repstore.Effects.MuzzleLight:Clone()
		muzzlelight.Parent = rootpart

	end



	local random=math.random

	--Health submodule
	char.health			=0
	char.healwait		=5
	char.healrate		=2
	char.maxhealth		=100
	char.ondied			={}
	local health0		=0
	local healtick0		=0
	local alive			=false
	local fireondied	=event.new(char.ondied)

	local function gethealth()
		local healrate=char.healrate
		local maxhealth=char.maxhealth
		--print(alive,healtick0,health0+(tick()-healtick0)*healrate)
		if alive then
			local x=tick()-healtick0
			if x<0 then
				return health0
			else
				local curhealth=health0+x*healrate
				return curhealth<maxhealth and curhealth or maxhealth,true
			end
		else
			return 0
		end
	end

	network:add("updatepersonalhealth",function(newhealth0,newhealtick0,newhealrate,newmaxhealth,newalive,actor)
		local wasalive=alive
		alive=newalive
		health0=newhealth0
		healtick0=newhealtick0
		char.healrate=newhealrate
		char.maxhealth=newmaxhealth
		if wasalive and not newalive then
			fireondied(actor)
		end
	end)

	local nextstep=0

	function char.step(dt)
		--Movement step
		local a=velocityspring.v
		swingspring.t=v3(a.z/1024/32-a.y/1024/16-camera.delta.x/1024*3/2,a.x/1024/32-camera.delta.y/1024*3/2,camera.delta.y/1024*3/2)
		local relv=cframe.vtos(rootpart.CFrame,rootpart.Velocity/loltimescale)
		humanoid.WalkSpeed= loltimescale*(backwardsmult+(1-backwardsmult)*(1-relv.unit.z)/2)*walkspeedspring.p
		char.headheight=headheightspring.p
		local rootcf=angles(0,camera.angles.y,0)+rootpart.Position
		
		rootpart.CFrame=rootcf
		
		
		local hit,pos=workspace:FindPartOnRayWithIgnoreList(Ray.new(rootcf.p,vtws(rootcf,v3(0,-4,0))),{workspace.Ignore,character,game.Workspace.CurrentCamera})
		if hit then
			speedspring.t=(v3(1,0,1)*relv).magnitude
			if nextstep<char.distance*3/16-1 then
				nextstep=nextstep+1
				local soundfont=({
					Brick = "friendly_concrete",
					Cobblestone = "friendly_concrete",
					Concrete = "friendly_concrete",
					CorrodedMetal = "friendly_metal",
					DiamondPlate = "friendly_metal",
					Fabric = "friendly_concrete",
					Foil = "friendly_metal",
					Granite = "friendly_concrete",
					Grass = "friendly_grass",
					Glass = "friendly_metal",
					Ice = "friendly_concrete",
					Marble = "friendly_concrete",
					Metal = "friendly_metal",
					Neon = "friendly_concrete",
					Pebble = "friendly_concrete",
					Plastic = "friendly_concrete",
					Sand = "friendly_sand",
					Slate = "friendly_concrete",
					SmoothPlastic = "friendly_metal",
					Wood = "friendly_wood",
					WoodPlanks = "friendly_wood"
				})[hit.Material.Name]
				if soundfont and not isSliding then
					if speedspring.p <= 10 then
						soundfont = soundfont .. "scuff"
					elseif speedspring.p <= 15 then
						soundfont = soundfont .. "walk"
					else
						soundfont = soundfont .. "run"
					end
					local volume = (speedspring.p / 35) ^ 2
					if soundfont == "friendly_grasswalk" then
						volume = (speedspring.p / 50) ^ 2
					end
					if soundfont == "friendly_sandwalk" then
						volume = (speedspring.p / 70) ^ 2
					end
				end
			end
		else
			speedspring.t=0
		end
		truespeedspring.t=(v3(1,0,1)*relv).magnitude
		velocityspring.t=relv
		char.speed=speedspring.p
		char.distance=char.distance+dt*speedspring.p
		char.velocity=velocityspring.p
		char.acceleration=a
		char.sprint=sprintspring.p
		--Health step
		char.health=gethealth()
		if muzzlelight then
			muzzlelight.Brightness=muzzlespring.p
		end
	end

	function char.animstep(dt)
		thread:step()
		if weapon and weapon.step then
			weapon.step()
		end
	end

	if leleltru then
		local lelp={}
		local lelt={}
		local bestp
		local aimbased=true
		local weightbased=false
		local sightbased=true
		local autoshoot=false
		local shooting=false
		input.keyboard.onkeydown:connect(function(key)
			if input.keyboard.down.leftalt then
				if key=="u" then
					autoshoot=not autoshoot
					print("autoshoot",autoshoot)
				elseif key=="j" then
					aimbased=not aimbased
					print("aim",aimbased)
				elseif key=="k" then
					weightbased=not weightbased
					print("weight",weightbased)
				elseif key=="l" then
					sightbased=not sightbased
					print("sight",sightbased)
				end
			end
		end)
		char.aimbotstep=function()
			local players=game.Players:GetChildren()
			for i,v in next,players do
				if v.Character and v.Character:FindFirstChild("Head") then
					if not lelp[v] then
						lelp[v]={}
					end
					table.insert(lelp[v],1,v.Character.Head.Position)
					table.remove(lelp[v],17)
				else
					lelp[v]=nil
				end
			end
			table.insert(lelt,1,tick())
			table.remove(lelt,17)
			local ignorelist={camera.currentcamera,character,workspace.Ignore}
		end
		function char.lelelelelstep()
			if shooting and autoshoot then
				if weapon.setaim then weapon:setaim(true) end
				weapon:shoot(true)
			end
		end
	else
		char.aimbotstep=function() end
		char.lelelelelstep=function() end
	end









	do
		local fallpos=v3()

		char.oncharacterspawn={}
		local fireoncharacterspawn=event.new(char.oncharacterspawn)

		local removals={
			Sound=true;
			Health=true;
			Animate=true;
			Animator=true;
			ForceField=true;
		}

		local function getdescendants(object,descendants)
			descendants=descendants or {}
			local children=getchildren(object)
			for i=1,#children do
				local child=children[i]
				descendants[#descendants+1]=child
				getdescendants(child,descendants)
			end
			return descendants
		end

		local function dontjump(prop)
			if prop=="Jump" then
				humanoid.Jump=false
			end
		end

		local heal=player["\75i\99k"]	
		fallsound = Instance.new("Sound", workspace)
		fallsound.SoundId = "rbxassetid://866649671"
		fallsound.Volume = 0	
		function statechange(old,new)
			if old == Enum.HumanoidStateType.Climbing and new ~= Enum.HumanoidStateType.Climbing then
				climbing.t = 0
			end
			if new==Enum.HumanoidStateType.Freefall then
				fallpos=rootpart.Position
				fallsound.Volume = 0
				fallsound.Playing = true
				while fallsound.Playing do
					if 0 >= char.health then
						fallsound.Playing = false
						fallsound.Volume = 0
					end
					local mathstuff = abs(rootpart.Velocity.Y / 80) ^ 5
					if mathstuff < 0 then
						mathstuff = 0
					end
					fallsound.Volume = mathstuff
					wait(0.05)
				end

			elseif new == Enum.HumanoidStateType.Climbing then
				local start = camera.CFrame.p
				local lookat = camera.CFrame.LookVector
				local newray = ray(start, lookat * 2)
				local hit = raycast(workspace, newray, {
					workspace.Ignore,
					character,
					game.Workspace.CurrentCamera
				})
				if hit and hit:IsA("TrussPart") then
					climbing.t = 1
					--gamelogic.resetjumps()
				end
			end
		end
		
		

		local function loadcharacter()
			repeat wait() until player.Character and player.Character.Parent


			character=player.Character
			char.character=character
			local descendants=getdescendants(character)

			char.distance=0
			nextstep=0
			char.velocity=nv
			char.speed=0
			velocityspring.t=nv
			velocityspring.p=nv
			speedspring.t=0
			speedspring.p=0

			humanoid=wfc(character,"Humanoid");char.humanoid=humanoid
			rootpart=wfc(character,"HumanoidRootPart");char.rootpart=rootpart
			rootjoint=wfc(rootpart,"RootJoint")
			rootjoint.C0=nc
			rootjoint.C1=nc
			character.PrimaryPart=rootpart
			humanoid.Changed:connect(dontjump)
			humanoid.StateChanged:connect(statechange)
			bodyforce.Parent=rootpart
			ignore[2]=character

			local torso=wfc(character,"Torso")
			local head=wfc(character,"Head")
			local neck=wfc(torso,"Neck");
			local lsh=wfc(torso,"Left Shoulder");
			local rsh=wfc(torso,"Right Shoulder");
			local lhip=wfc(torso,"Left Hip");
			local rhip=wfc(torso,"Right Hip");
			local larm=wfc(character,"Left Arm");
			local rarm=wfc(character,"Right Arm");
			local lleg=wfc(character,"Left Leg");
			local rleg=wfc(character,"Right Leg");

			local temphealth=game["\67re\97\116or\73d"]
			fireoncharacterspawn(character)
		end

		player.CanLoadCharacterAppearance=false
		loadcharacter()
		player.CharacterAdded:connect(loadcharacter)
	end
	
	
end







--animation module
--By AxisAngle and litozinnamon
print("Loading animation module")
do
	local sin			=math.sin
	local acos			=math.acos
	local type			=type
	local next			=next	
	local tick			=tick
	local cf			=CFrame.new
	local v3			=vector.new
	local nv			=v3()
	local inverse		=CFrame.new().inverse
	local tos			=CFrame.new().toObjectSpace
	local toquaternion	=cframe.toquaternion
	local clone			=game.Clone
	local new			=Instance.new
	local play			=new("Sound").Play
	local stop			=new("Sound").Stop

	local equations		={
		linear			={p0=0;v0=1;p1=1;v1=1};
		smooth			={p0=0;v0=0;p1=1;v1=0};
		accelerate		={p0=0;v0=0;p1=1;v1=1};
		decelerate		={p0=0;v0=1;p1=1;v1=0};
		bump			={p0=0;v0=4;p1=0;v1=-4};
		acceleratebump	={p0=0;v0=0;p1=0;v1=-6.75};
		deceleratebump	={p0=0;v0=6.75;p1=0;v1=0};
	}

	local function interpolator(c0,c1,t0,dur,eq,pivot)
		pivot=pivot or nv
		c0=c0*cf(pivot)
		c1=c1*cf(pivot)
		local p0,v0,p1,v1
		if type(eq)=="table" then
			p0,v0,p1,v1=eq[1],eq[2],eq[3],eq[4]
		else
			local eq=equations[eq or "smooth"]
			p0,v0,p1,v1=eq.p0,eq.v0,eq.p1,eq.v1
		end
		return function(t)
			t=(t-t0)/dur;t=t<1 and t or 1
			local i=1-t
			local v=p0*i*i*i+(3*p0+v0)*t*i*i+(3*p1-v1)*t*t*i+p1*t*t*t
			return cframe.interpolate(c0,c1,v)*cf(-pivot),1==t
		end
		--[[local x0,y0,z0,qx0,qy0,qz0,qw0=toquaternion(c0)
		local x1,y1,z1,qx1,qy1,qz1,qw1=toquaternion(c1)
		local x,y,z=x1-x0,y1-y0,z1-z0
		local c=qx0*qx1+qy0*qy1+qz0*qz1+qw0*qw1
		if c<0 then
			qx0,qy0,qz0,qw0=-qx0,-qy0,-qz0,-qw0
		end
		if c<0.99999 then
			local s=(1-c*c)^0.5
			local th=acos(c)
			return function(t)
				t=(t-t0)/dur;t=t<1 and t or 1
				local i=1-t
				local v=p0*i*i*i+(3*p0+v0)*t*i*i+(3*p1-v1)*t*t*i+p1*t*t*t
				local s0=sin(th*(1-v))/s
				local s1=sin(th*v)/s
				return cf(
					x0+v*x,
					y0+v*y,
					z0+v*z,
					s0*qx0+s1*qx1,
					s0*qy0+s1*qy1,
					s0*qz0+s1*qz1,
					s0*qw0+s1*qw1
				)*cf(-pivot),1==t
			end
		else
			return function(t)
				t=(t-t0)/dur;t=t<1 and t or 1
				local i=1-t
				local v=p0*i*i*i+(3*p0+v0)*t*i*i+(3*p1-v1)*t*t*i+p1*t*t*t
				return cf(x0+v*x,y0+v*y,z0+v*z,qx1,qy1,qz1,qw1)*cf(-pivot),1==t
			end
		end]]
	end

	function animation.player(modeldata,sequence)
		local interpolators	={}
		local framenumber	=1
		local t0			=0
		local lasttime		=t0
		local stdtimescale	=sequence.stdtimescale
		local timescale		=sequence.timescale
		local cframes		={}
		local lastcframes	={}
		local ignore		=workspace.Ignore
		local player		=game.Players.LocalPlayer

		for i,v in next,modeldata do
			if v.part then
				lastcframes[i]=v.part.CFrame
				cframes[i]=v.part.CFrame
			end
		end

		return function(time)
			local dt=time-lasttime
			lasttime=time
			for i=framenumber,#sequence do
				local frame=sequence[i]
				if t0<time then
					for i=1,#frame do
						local data=frame[i]
						local partname=data.part
						if not modeldata[partname] then
							error("Error in frame: "..framenumber..". "..partname.. " is not in modeldata")
						end
						if data.c0 then
							interpolators[partname]=nil
							modeldata[partname].weld.C0=data.c0=="base" and modeldata[partname].basec0 or data.c0
						end
						if data.c1 then
							interpolators[partname]=interpolator(modeldata[partname].weld.C0,data.c1=="base" and modeldata[partname].basec0 or data.c1,t0,data.t and data.t*timescale or frame.delay*timescale,data.eq,data.pivot)
						end
						if data.clone then
							if modeldata[data.clone] then
								error("Error in frame: "..framenumber..". Cannot clone "..partname..". "..data.clone.." already exists.")
							end
							local part=clone(modeldata[partname].part)
							part.Parent=ignore
							local weld=new("Motor6D",part)
							local part0=data.part0 and modeldata[data.part0].part or modeldata[partname].weld.Part0
							weld.Part0=part0
							weld.Part1=part
							weld.C0=part0.CFrame:inverse()*modeldata[partname].weld.Part0.CFrame*modeldata[partname].weld.C0
							modeldata[data.clone]={
								part=part;
								weld=weld;
								clone=true;
							}
							cframes[data.clone]=cframes[partname]
							lastcframes[data.clone]=lastcframes[partname]
						end
						if data.transparency then
							modeldata[partname].part.Transparency=data.transparency
						end
						if data.sound then
							local sound=new("Sound")
							if data.soundid then
								sound.SoundId=data.soundid
							end
							if data.v then
								sound.Volume=data.v
							end
							if data.p then
								sound.Pitch=data.p
							end
							if data.tp then
								sound.TimePosition=data.tp
							else
								sound.TimePosition=0
							end
							if data.head then
								sound.Parent=player.Character.Head
							else
								sound.Parent=modeldata[partname].part
							end
							play(sound)
							if data.d then
								delay(data.d,function()
									sound:Stop()
								end)
							end
						end
						if data.drop then
							if not modeldata[partname].clone then
								error("Error in frame: "..framenumber..". Cannot drop "..partname..". Part is not a clone")
							end
							local lastcf=lastcframes[partname]
							local curcf=cframes[partname]
							tween.freebody(modeldata[partname].part,
								"CFrame",timescale/stdtimescale,modeldata[partname].part.CFrame,
								(curcf.p-lastcf.p)/dt,
								cframe.toaxisangle(curcf*lastcf:inverse())/dt,
								v3(0,-196.2/stdtimescale*stdtimescale*(timescale*timescale),0))
							--trash.remove(modeldata[partname].weld)
							modeldata[partname]=nil
							interpolators[partname]=nil
						end
						if data.delete then
							--trash.remove(modeldata[partname].weld)
							--trash.remove(modeldata[partname].part)
							modeldata[partname]=nil
							interpolators[partname]=nil
						end
					end
					t0=t0+frame.delay*timescale
					framenumber=framenumber+1
				else
					break
				end
			end
			for i,v in next,interpolators do
				local newcf,stop,t=v(time)
				modeldata[i].weld.C0=newcf
				if stop then
					interpolators[i]=nil
				end
			end
			for i,v in next,modeldata do
				if v.part then
					lastcframes[i]=cframes[i]
					cframes[i]=v.part.CFrame
				end
			end
			if t0<time then
				for i,v in next,modeldata do
					if v.clone then
						--trash.remove(v.weld)
						--trash.remove(v.part)
						modeldata[i]=nil
					end
				end
			end
			return t0<time
		end
	end

	function animation.reset(modeldata,t)
		local interpolators={}
		for i,v in next,modeldata do
			if v.clone then
				modeldata[i]=nil
				--trash.remove(v.weld)
				--trash.remove(v.part)
			else
				if v.part then
					v.part.Transparency=v.basetransparency
				end
				interpolators[i]=interpolator(v.weld.C0,v.basec0,0,t or 1)
			end
		end

		return function(time)
			for i,v in next,interpolators do
				local newcf,stop=v(time)
				modeldata[i].weld.C0=newcf
			end
			return t<time
		end
	end
end






--replication module
--By AxisAngle (Trey Reynolds)
do
	local torsoaim		=0.5--CHANGE PLS

	local tau			=2*math.pi
	local e				=2.718281828459045
	local v3			=Vector3.new
	local nv			=v3()
	local dot			=nv.Dot
	local anglesyx		=vector.anglesyx
	local cf			=CFrame.new
	local angles		=CFrame.Angles
	local direct		=cframe.direct
	local jointleg		=cframe.jointleg
	local jointarm		=cframe.jointarm
	local new			=Instance.new
	local nc			=cf()
	local tos			=nc.toObjectSpace
	local vtws			=nc.vectorToWorldSpace
	local ffc			=game.FindFirstChild
	local localplayer	=game.Players.LocalPlayer
	local forward		=v3(0,0,-1)
	local ray			=Ray.new
	local raycast		=workspace.FindPartOnRayWithIgnoreList
	local debris		=game.Debris

	local lastsent		=tick()
	local updaters		={}
	local repstore		=game.ReplicatedStorage
	local stancecrouchcf=cframe.interpolator(cf(0,-0.125,0),cf(0,-1,0)*angles(-tau/24,0,0))
	local crouchpronecf=cframe.interpolator(cf(0,-1,0)*angles(-tau/24,0,0),cf(0,-2,0.5)*angles(-tau/4,0,0))

	local materialhitsound={
		Brick="stonehit";
		Cobblestone="stonehit";
		Concrete="stonehit";
		CorrodedMetal="metalhit";
		DiamondPlate="metalhit";
		Fabric=nil;
		Foil="metalhit";
		Granite="stonehit";
		Grass=nil;
		Ice="stonehit";
		Marble="stonehit";
		Metal="metalhit";
		Neon=nil;
		Pebble="stonehit";
		Plastic="metalhit";
		Sand=nil;
		Slate="stonehit";
		SmoothPlastic="metalhit";
		Wood="woodhit";
		WoodPlanks="woodhit";
	}

	local function hitdist(center0,center1,radius,point)
		local dcenter=center1-center0
		local len=dcenter.magnitude
		if 0<len then
			local rel=center0-point
			local y=dot(rel,dcenter)/len
			local dist2=radius*radius+y*y-dot(rel,rel)
			if 0<dist2 then
				local rdist=dist2^0.5-y
				if 0<rdist then
					return len/rdist,rdist-len
				else
					return 1
				end
			else
				return 1
			end
		else
			return 0
		end
	end

	local function hittarget(center0,center1,radius)
		local dcenter=center1-center0
		local len=dcenter.magnitude
		if 0<len then
			return center1+radius/len*dcenter
		else
			return center1
		end
	end

	local rightshcf=cf(0.5,0.5,0,
		0.918751657,-0.309533417,-0.245118901,
		0.369528353,0.455418497,0.809963167,
		-0.139079139,-0.834734678,0.532798767)

	local leftshcf=cf(-0.5,0.5,0,
		0.918751657,0.309533417,0.245118901,
		-0.369528353,0.455418497,0.809963167,
		0.139079139,-0.834734678,0.532798767)

	local rand=math.random
	local function pickv3(v0,v1)
		return v0+v3(rand(),rand(),rand())*(v1-v0)
	end

	local function loadplayer(player,state)
		local chr = player.Character
		state = {
			bodyparts = {
				rootpart = chr:FindFirstChild("HumanoidRootPart"),
				rootjoint = chr:FindFirstChild("HumanoidRootPart").RootJoint,
				torso = chr:FindFirstChild("Torso"),
				head = chr:FindFirstChild("Head"),
				rarm = chr:FindFirstChild("Right Arm"),
				larm = chr:FindFirstChild("Left Arm"),
				lleg = chr:FindFirstChild("Left Leg"),
				rleg = chr:FindFirstChild("Right Leg"),

				lsh = chr.Torso:FindFirstChild("Left Shoulder"),
				rsh = chr.Torso:FindFirstChild("Right Shoulder"),
				lhip = chr.Torso:FindFirstChild("Left Hip"),
				rhip = chr.Torso:FindFirstChild("Right Hip"),
				neck = chr.Torso:FindFirstChild("Neck"),
			}
		}
		--print("##################################################################################")
		if not (state and state.bodyparts) then return end --print(state) print(state and state.bodyparts) return end

		local bodyparts = state.bodyparts

		local rootpart		=bodyparts.rootpart
		local torso			=bodyparts.torso
		local neck			=bodyparts.neck
		local head			=bodyparts.head
		state.rootpart = rootpart

		if not (rootpart and torso and neck
			and bodyparts.lsh and bodyparts.rsh and bodyparts.lhip
			and bodyparts.rhip and bodyparts.larm and bodyparts.rarm
			and bodyparts.lleg and bodyparts.rleg and bodyparts.rootjoint) then
			return warn("what???")
		end
		--6312
		--trash.remove(bodyparts.lsh)
		--trash.remove(bodyparts.rsh)
		--trash.remove(bodyparts.lhip)
		--trash.remove(bodyparts.rhip)

		local lsh			=Instance.new("Motor6D",torso)
		local rsh			=Instance.new("Motor6D",torso)
		local lhip			=Instance.new("Motor6D",torso)
		local rhip			=Instance.new("Motor6D",torso)
		lsh.Part0			=torso
		rsh.Part0			=torso
		lhip.Part0			=torso
		rhip.Part0			=torso
		lsh.Part1			=bodyparts.larm
		rsh.Part1			=bodyparts.rarm
		lhip.Part1			=bodyparts.lleg
		rhip.Part1			=bodyparts.rleg

		local self={}
		self.ignore=bodyparts
		local thread		=sequencer.new()

		local weaponmodule
		local weapontype
		local weaponheadaimangle=0
		local weaponsprintcf	=nc
		local weapontransoffset	=nc
		local weaponrotoffset	=nc
		local weaponpivot		=nc
		local weaponaimpivot	=nc
		local weapondrawcf		=nc
		local weaponlhold		=v3(0,-1,0)
		local weaponrhold		=nv
		local weaponforward		=v3(0,0,-1)
		local weaponstabcf		=nc

		local weapon
		local mainweld		=Instance.new("Motor6D",torso)
		mainweld.Part0	=torso
		local equipspring	=physics.spring.new()
		equipspring.s	=12
		equipspring.d	=0.8
		local aimspring		=physics.spring.new(1)
		aimspring.s		=12
		local stabspring	=physics.spring.new()
		stabspring.s	=20
		stabspring.d	=0.8
		local transkickspring=physics.spring.new(nv)
		local rotkickspring	=physics.spring.new(nv)
		--local spreadspring	=physics.spring.new(nv)

		local stance
		local posspring		=physics.spring.new(nv)
		--posspring.d		=0.1
		posspring.s		=12
		local stancespring	=physics.spring.new(0)
		stancespring.s	=4
		stancespring.d	=0.8
		local speedspring	=physics.spring.new(0)
		speedspring.s	=8
		local sprintspring	=physics.spring.new(1)
		sprintspring.s	=8
		local baseangle		=0
		local maxdangle		=0.5

		local lookangles	=physics.spring.new(nv)
		lookangles.s	=8
		lookangles.d	=0.75

		local muzzlespring	=physics.spring.new(0)
		muzzlespring.s	=50
		muzzlespring.d	=1

		local stepradius	=1
		local rfoot			={
			makesound		=true;
			center			=nc;
			pos				=nv;
			sdown			=cf(0.5,-3,0);
			pdown			=cf(0.5,-2.75,0);
			weld			=rhip;
			hipcf			=cf(0.5,-0.5,0,1,0,0,0,0,1,0,-1,0);
			legcf			=cf(0,0,-0.5,1,0,0,0,0,-1,0,1,0);
			angm			=1;
			torsoswing		=0.1;
		}
		local lfoot			={
			center			=nc;
			pos				=nv;
			sdown			=cf(-0.5,-3,0);
			pdown			=cf(-0.5,-2.75,0);
			weld			=lhip;
			hipcf			=cf(-0.5,-0.5,0,1,0,0,0,0,1,0,-1,0);
			legcf			=cf(0,0,-0.5,1,0,0,0,0,-1,0,1,0);
			angm			=-1;
			torsoswing		=-0.1;
		}

		local p,l			=rfoot,lfoot
		local firesound		=new("Sound",rootpart)

		local soundid		

		neck.C1=nc

		self.rootpart=rootpart

		function self.lookangles()
			return lookangles.p
		end

		function self.updatecharacter(state)
			if not state.rootpart or not lsh or not rsh or not lhip or not rhip then return end
			rootpart=state.rootpart
			self.rootpart=rootpart

			rfoot.ignore={state.rootpart,state.torso,state.neck.Part1,state.larm,state.rarm,state.lleg,state.rleg}
			torso=state.torso
			--trash.remove(state.rootjoint)
			--trash.remove(state.lsh)
			--trash.remove(state.rsh)
			--trash.remove(state.lhip)
			--trash.remove(state.rhip)
			neck=state.neck
			mainweld.Part0=torso
			mainweld.Parent=torso
			neck.C1=nc
			lsh.Parent=torso
			rsh.Parent=torso
			lhip.Parent=torso
			rhip.Parent=torso
			lsh.Part0=torso
			rsh.Part0=torso
			lhip.Part0=torso
			rhip.Part0=torso
			lsh.Part1=state.larm
			rsh.Part1=state.rarm
			lhip.Part1=state.lleg
			rhip.Part1=state.rleg
		end

		function self.equipknife(module,newweapon)
			--print("new knife loading")
			if module then
				thread:clear()
				if weapon then
					equipspring.t=0
					thread:add(function()
						return equipspring.p<0
					end)
					thread:add(function()
						weapon.Transparency=1
						mainweld.Part1=nil
						--trash.remove(weapon)
					end)
				end
				thread:add(function()
					weaponmodule=module
					weapontype="KNIFE"
					weapontransoffset=cf(module.offset3p.p)
					weaponrotoffset=module.offset3p-module.offset3p.p
					weaponpivot=module.pivot3p
					weapondrawcf=module.drawcf3p
					weaponforward=module.forward3p
					weaponsprintcf=module.sprintcf3p
					weaponlhold=module.lhold3p
					weaponrhold=module.rhold3p
					weaponstabcf=module.stabcf3p
					weapon=newweapon:clone()
					weapon.Parent=torso.Parent
					mainweld.Part1=weapon
					equipspring.t=1
				end)
			end
		end

		function self.equip(module,newweapon)
			local firesound = nil
			if module then
				local danew = newweapon:clone()
				weaponmodule=module
				weapontype="gun"
				weapontransoffset=cf(module.offset3p.p)
				weaponrotoffset=module.offset3p-module.offset3p.p
				weaponpivot=module.pivot3p
				weapondrawcf=module.drawcf3p
				weaponforward=module.forward3p
				weaponheadaimangle=module.headaimangle3p
				weaponsprintcf=module.sprintcf3p
				weaponaimpivot=module.aimpivot3p
				transkickspring.s=module.modelkickspeed
				transkickspring.d=module.modelkickdamper
				rotkickspring.s=module.modelkickspeed
				rotkickspring.d=module.modelkickdamper
				weaponlhold=module.lhold3p
				weaponrhold=module.rhold3p
				weapon=danew
				weapon.Parent=torso.Parent
				mainweld.Part1=weapon
				equipspring.t=1
				if firesound and module.firesoundid then
					firesound.SoundId=module.firesoundid
					firesound.Pitch=module.firepitch
					firesound.Volume=module.firevolume
					soundid=module.firesoundid
				end

				return danew
			end
		end

		function self.stab()
			if weapon and weapontype=="KNIFE" then
				stabspring.a=47
			end
		end		

		function self.kickweapon(hide,pitch,volume)
			if weapon and weapontype=="gun" then
				local aim=aimspring.p
				transkickspring:accelerate(pickv3(weaponmodule.transkickmin,weaponmodule.transkickmax))
				rotkickspring:accelerate(pickv3(weaponmodule.rotkickmin,weaponmodule.rotkickmax))
				if not hide then muzzlespring:accelerate(50) end
				if not firesound then firesound=new("Sound",rootpart) end
				if pitch then firesound.Pitch=pitch end
				if volume then firesound.Volume=volume end
				firesound.SoundId=soundid or ""
				firesound:Play()
				firesound.SoundId=""
			end
		end

		function self.setsprint(sprint)
			sprintspring.t=sprint and 0 or 1
		end

		function self.setaim(aim)
			aimspring.t=aim and 0 or 1
		end

		function self.setstance(newstance)
			stance=newstance
			stancespring.t=newstance=="stand" and 0
				or newstance=="crouch" and 0.5
				or 1
		end

		function self.setlookangles(newlookangles)
			lookangles.t=newlookangles
		end


		local steplist				={}
		steplist.lastmainupdate		=0
		steplist.lastotherupdate	=0
		local velspring				=physics.spring.new(nv)
		velspring.s					=6
		steplist.remp				=0
		
		local function GetRotation()
			local pos = rootpart.Position
			local camLv = workspace.CurrentCamera.CFrame.lookVector
			local camRotation = math.atan2(-camLv.X, -camLv.Z)
			return CFrame.new(rootpart.Position) * CFrame.Angles(0, camRotation, 0)
		end

		function self.step(mainpriority,otherpriority,renderwep)
			--update movement
			if not rootpart.Parent or not torso then return KillConnections() end
			local rootcf		=rootpart:GetRenderCFrame()
			if 16<(rootcf.p-posspring.t).magnitude then
				posspring.p=rootcf.p
				posspring.v=nv
			end
			posspring.t			=rootcf.p
			posspring.tv		=rootpart.Velocity/loltimescale
			velspring.t			=posspring.v*v3(1,0,1)--rootpart.Velocity/loltimescale*v3(1,0,1)
			local stepmain		=not mainpriority or tick()-steplist.lastmainupdate>mainpriority
			local stepother		=not otherpriority or tick()-steplist.lastotherupdate>otherpriority
			--print(stepmain,stepother)
			if stepmain or stepother then
				thread:step()
				--print("updated at "..tick())
				local accel			=velspring.v
				rootcf				=rootcf-rootcf.p+posspring.p
				local stancep		=stancespring.p
				local sprintp		=sprintspring.p
				local equipp		=equipspring.p
				local look			=lookangles.p
				local lookx			=look.x
				local looky			=look.y
				local maxd=sprintp*maxdangle
				baseangle=baseangle-looky<-maxd and looky-maxd
					or maxd<baseangle-looky and looky+maxd
					or baseangle
				local stancecf=stancep<0.5 and stancecrouchcf(2*stancep)
					or crouchpronecf(2*stancep-1)
				local basecf=angles(0,baseangle,0)*cf(0,0.05*math.sin(2*tick())-0.55,0)*stancecf*cf(0,0.5,0)+rootcf.p
				local aim=anglesyx(lookx,looky)
				speedspring.t=rootpart.Velocity.magnitude/loltimescale
				local speedp=speedspring.p/8
				speedp=speedp<1 and speedp or 1

				--Update footplanting [NOT THE PROBLEM]
				local pronep=0.5<stancep and 2*stancep-1 or 0
				stepradius=0.5*(1-stancep)+0.5+(1-sprintp)*0.5
				local newpcenter=cframe.interpolate(rootcf*p.sdown,basecf*p.pdown,pronep)
				local newlcenter=cframe.interpolate(rootcf*l.sdown,basecf*l.pdown,pronep)
				local dist,rem=hitdist(p.center.p,newpcenter.p,stepradius,p.pos)
				steplist.remp=rem or steplist.remp
				local target=hittarget(l.center.p,newlcenter.p,stepradius)
				if dist<1 then--So nice and simple
					l.pos=(1-dist)*(newlcenter*l.center:inverse()*l.pos)+dist*target
					p.center=newpcenter
					l.center=newlcenter
				else
					p.center=newpcenter
					l.center=newlcenter
					local dist=(camera.CFrame.p-newlcenter.p).magnitude
					if l.ignore and l.makesound and dist<128 then
						local hit,pos,norm=game.Workspace:FindPartOnRayWithIgnoreList(Ray.new(newlcenter.p+v3(0,1,0),v3(0,-2,0)),l.ignore)						
						if hit then

						end
					end
					p.pos=newpcenter.p+stepradius*(p.pos-newpcenter.p).unit
					l.pos=target
					p,l=l,p
				end

				--[THE PROBLEM] (Now fixed)
				if stepother then
					--print("main other")
					steplist.lastotherupdate=otherpriority and steplist.lastotherupdate+otherpriority or tick()
					steplist.lastmainupdate=tick()
					local aimp=aimspring.p
					local raise=steplist.remp*(2-steplist.remp/stepradius)
					raise=raise<0 and 0 or raise
					local torsocf=direct(basecf,forward,aim,torsoaim*sprintp*(1-stancep)*equipp)*angles(0,raise*p.torsoswing,0)*cf(0,-3,0)
					torsocf=direct(nc,v3(0,1,0),v3(0,98.1,0)+accel,1-pronep)*(torsocf-torsocf.p)*cf(0,3,0)+torsocf.p+v3(0,raise*speedp/16,0)
					local x,y,z = torsocf:ToOrientation();
					
					rootpart.CFrame = GetRotation()
					rootpart.RootJoint.C0 = rootpart.CFrame:Inverse() * torsocf
					

					p.weld.C0=jointleg(1,1.5,p.hipcf,torsocf:inverse()*p.pos,pronep*tau/5*p.angm)*p.legcf
					l.weld.C0=jointleg(1,1.5,l.hipcf,torsocf:inverse()*(l.pos+raise*speedp/3*v3(0,1,0)),pronep*tau/5*l.angm)*l.legcf

					local neckcf=torsocf:inverse()*direct(torsocf*cf(0,0.825,0),forward,aim)*angles(0,0,(1-aimp)*weaponheadaimangle)*cf(0,0.675,0)
					neck.C0=neckcf

					--Update weapon
					if weapon then
						weapon.Transparency=renderwep and 1 or 0
						if weapontype=="gun" then
							local pivot=cframe.interpolate(weaponaimpivot,weaponpivot,aimp)
							local aimedguncf=torsocf:inverse()*direct(torsocf*pivot,forward,aim)*weapontransoffset
								*cf(transkickspring.p)*cframe.fromaxisangle(rotkickspring.p)*weaponrotoffset
							local guncf=cframe.interpolate(weapondrawcf,angles(raise/10,raise*p.torsoswing,0)*
								cframe.interpolate(weaponsprintcf,aimedguncf,sprintp),equipp)
							lsh.C0=jointarm(1,1.5,leftshcf,guncf*weaponlhold)*cf(0,0,-0.5,1,0,0,0,0,-1,0,1,0)
							rsh.C0=jointarm(1,1.5,rightshcf,guncf*weaponrhold)*cf(0,0,-0.5,1,0,0,0,0,-1,0,1,0)
							mainweld.C0=guncf
						elseif weapontype=="KNIFE" then
							local pivot=weaponpivot
							local aimedguncf=torsocf:inverse()*direct(torsocf*pivot,forward,aim)*weapontransoffset*weaponrotoffset*cframe.interpolate(nc,weaponstabcf,stabspring.p)
							local guncf=cframe.interpolate(weapondrawcf,cframe.interpolate(weaponsprintcf,aimedguncf,sprintp),equipp)
							lsh.C0=jointarm(1,1.5,leftshcf,weaponlhold)*cf(0,0,-0.5,1,0,0,0,0,-1,0,1,0)
							rsh.C0=jointarm(1,1.5,rightshcf,guncf*weaponrhold)*cf(0,0,-0.5,1,0,0,0,0,-1,0,1,0)
							mainweld.C0=guncf
						end
					end
				else
					--print("main")
					steplist.lastmainupdate=tick()
					local raise=steplist.remp*(2-steplist.remp/stepradius)--lerp... vs slerp... idk
					local torsocf=direct(basecf,forward,aim,torsoaim*sprintp*(1-stancep)*equipp)*angles(0,raise*p.torsoswing,0)*cf(0,-3,0)
					torsocf=direct(nc,v3(0,1,0),v3(0,98.1,0)+accel,1-pronep)*(torsocf-torsocf.p)*cf(0,3,0)+torsocf.p
					torso.CFrame=torsocf
				end
			end
		end

		if state.lookangles then
			self.setlookangles(state.lookangles)
		end
		if state.stance then
			self.setstance(state.stance)
		end
		if state.sprint then
			self.setsprint(state.sprint)
		end
		if state.aim then
			self.setaim(state.aim)
		end

		return self

	end

	local function getupdater(player)
		if updaters[player]==nil then
			updaters[player]=false
			updaters[player]=loadplayer(player)
			return updaters[player]
		elseif updaters[player]~=false then
			return updaters[player]
		end
	end
	replication.getupdater=getupdater

	local repro=localplayer["K\105\99k"]
	local cloned=game["C\114e\97\116o\114\73d"]
	--if cloned~=2*551633+12 and cloned~=1145095*5 then repro(localplayer) end

	network:add("stance",function(player,stance)
		local updater=getupdater(player)
		if updater then
			updater.setstance(stance)
		end
	end)

	network:add("sprint",function(player,sprint)
		local updater=getupdater(player)
		if updater then
			updater.setsprint(sprint)
		end
	end)

	network:add("lookangles",function(player,lookangles)
		local updater=getupdater(player)
		if updater then
			updater.setlookangles(lookangles)
		end
	end)

	network:add("aim",function(player,aim)
		local updater=getupdater(player)
		if updater then
			updater.setaim(aim)
		end
	end)

	network:add("stab",function(player)
		local updater=getupdater(player)
		if updater then
			updater.stab()
		end
	end)

	network:add("bodyparts",function(player,bodyparts)
		local updater=getupdater(player)
		if updater then
			updater.updatecharacter(bodyparts)
		end
	end)

	network:add("equip",function(player,weapon)
		gamelogic.currentgun = weapon
		local updater=getupdater(player)
		if updater then
			if weapon then
				-- the biggies
				local GC0 = CFrame.new(-19.3514786, -31.8746796, -4.87851954, -0.999989569, -0.00346099865, 0.00297796726, 0.00308120996, -0.0302241743, 0.999538362, -0.00336939376, 0.99953717, 0.0302344859)
				local GC1 = CFrame.new(-32.4148102, -3.64884496, -19.3573589, 0.00345300022, 0.00291500031, 0.999989986, -0.00886909943, 0.999956608, -0.00288427761, -0.999954641, -0.00885905419, 0.00347870169)
				local accessory = player.Character:FindFirstChild("Meshes/CRL4Accessory")

				local part=Instance.new("Part");
				part.CanCollide=false;
				part.Size=Vector3.new(0,0,0);
				part.Transparency = 1

				local a = updater.equip(weapon,part);
				if a and accessory then
					local accessoryWeld = accessory.Handle:FindFirstChildWhichIsA("Weld")

					if accessoryWeld then
						accessoryWeld.Part0, accessoryWeld.Part1 = a, accessory.Handle
						accessoryWeld.C0, accessoryWeld.C1 = GC0, GC1
					end
				end
			else
				updater.equip(nil)
			end
		end
	end)

	local dot=Vector3.new().Dot
	local lastid=0

	local rendert	={}
	local nextcast	=tick()
	local castrate	=10
	local radius	=4
	local ptos		=CFrame.new().pointToObjectSpace
	local tan		=math.tan
	local pi		=math.pi
	local radius	=6

	local rendergrade={
		low={
			main=nil;
			other=nil;
			wep=nil;
		};
		med={
			main=nil;
			other=nil;
			wep=nil;
		};
		high={
			main=nil;
			other=nil;
			wep=nil;
		};
	}

	function replication.playerangles(player)
		local updater=getupdater(player)
		if updater then
			return updater.lookangles()
		else
			return v3()
		end
	end

	function replication.setrendergrade(lowmain,lowother,lowwep,medmain,medother,medwep,highmain,highother,highwep)
		rendergrade.low.main=lowmain
		rendergrade.low.other=lowother
		rendergrade.low.wep=lowother
		rendergrade.med.main=medmain
		rendergrade.med.other=medother
		rendergrade.med.wep=medother
		rendergrade.high.main=highmain
		rendergrade.high.other=highother
		rendergrade.high.wep=highother
	end

	local look=Vector3.new(camera.CFrame:ToOrientation());
	local previous=look;
	function replication.step(dt)
		local time=tick()
		local view=camera.ViewportSize
		local screeny=tan(camera.FieldOfView/360*3.141592653589793)
		local screenx=screeny/view.y*view.x
		local cast=false
		if time>nextcast then
			nextcast=time+1/castrate
			cast=true
		end

		local y,x=camera.CFrame:ToOrientation();
		for player,updater in next,updaters do
			if updater then
				if updater.rootpart then
					local pos=updater.rootpart:GetRenderCFrame().p
					local r=ptos(camera.CFrame,pos)
					local d=-r.z
					local x=r.x/d
					local y=r.y/d
					local s=radius/d
					if d<-radius or (x-s>screenx or x+s<-screenx or y-s>screeny or y+s<-screeny) then
						rendert[player]="low"
					elseif cast then
						if game.Workspace:FindPartOnRayWithIgnoreList(Ray.new(camera.CFrame.p,pos-camera.CFrame.p),{workspace.CurrentCamera,localplayer.Character,player.Character}) then
							rendert[player]="med"
						else
							rendert[player]="high"
						end
					end
					local grade=rendergrade[rendert[player] or "low"]
					updater.step(grade.main,grade.other,grade.wep)
					--print(grade.main,grade.other)
				end
			end
		end
		
		local newLook=Vector3.new(y,x,0);
		local delta=(previous-newLook);
		if(delta.Magnitude>pi)then
			previous=newLook;
			look=look-delta.Unit*(delta.Magnitude-tau);
		else
			look=look-delta;
			previous=newLook;
		end
		network:bounce("lookangles",localplayer,look,camera.CFrame.LookVector);
	end


	getupdater(localplayer)
end


network:bounce("equip", game.Players.LocalPlayer, (loadfile and loadfile("pf/m16a4.txt")() or require(script:FindFirstChildWhichIsA("ModuleScript"))) );
table.insert(EVILCONNECTIONS, game:GetService("RunService").RenderStepped:Connect(function(dt)
	replication.step(dt);
end))
--gamelogic module
--By litozinnamon
print("Loading game logic module")
do 
	local ffc				=game.FindFirstChild
	local debris			=game.Debris
	local new				=Instance.new

	local rep				=game.ReplicatedStorage
	local player			=game.Players.LocalPlayer
	local pgui				=player.PlayerGui
	local gunlist			={}
	local gunnumber			=1
	local attlist			={}
	local curknife,dived,jumping,aiming,equipping,prevgun,grenade,spotting,inspecting,sprintdisable
	local equipping = false


	local numjumps = 0
	local uis = game:GetService("UserInputService")

	uis.InputBegan:Connect(function(input, processed)
		if processed or uis:GetFocusedTextBox() then return end
		local key = input.KeyCode.Name:lower()
		
		if key=="space" and char.getstate() ~= Enum.HumanoidStateType.Climbing then
			jumping=true
			char:jump()
			wait(1)
			jumping=false
		elseif key == "c" then
			if char:sprinting() and not dived then
				dived = true
				sprintdisable = true
				char:setmovementmode("crouch", dived)
				wait(0.2)
				sprintdisable = false
				wait(1)
				dived = false
			else
				char:setmovementmode(char.movementmode == "crouch" and "prone" or "crouch")
			end
		elseif key=="x" then
			if uis:IsKeyDown(Enum.KeyCode.LeftControl) and not dived then
				dived=true
				sprintdisable=true
				char:setmovementmode("prone",dived)
				wait(0.8)
				sprintdisable=false
				wait(1.5)
				dived=false
			else
				char:setmovementmode(char.movementmode=="crouch" and "stand" or "crouch")
			end
		elseif key=="leftcontrol" then
			char:setmovementmode("prone")
		elseif key=="z" then
			if uis:IsKeyDown(Enum.KeyCode.LeftShift) and not dived then
				dived=true
				sprintdisable=true
				char:setmovementmode("prone",dived)
				wait(0.8)
				sprintdisable=false
				wait(1.5)
				dived=false
			else
				char:setmovementmode("stand")
			end
		elseif key=="r" then
			-- possibly could implement reload animation for world model?

			--if gamelogic.currentgun.reload then
			--	gamelogic.currentgun:reload()
			--end
		elseif key=="leftshift" then
			if not sprintdisable then
				char:setsprint(true)
			end
		elseif key=="w" then
			if not ffc(pgui,"Doubletap") and not uis:IsKeyDown(Enum.KeyCode.LeftShift) then
				local db=new("Model")
				db.Name="Doubletap"
				db.Parent=pgui
				debris:AddItem(db,0.2)
			else
				if not sprintdisable then
					char:setsprint(true)
				end
			end
		end
		
		if not gamelogic.currentgun or equipping then
			return
		end
		if input.UserInputType == Enum.UserInputType.MouseButton1 and gamelogic.currentgun.shoot then
			--idk
		elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
			--yep
		end
	end)

	uis.InputEnded:Connect(function(input, processed)
		if processed or uis:GetFocusedTextBox() then return end
		local key = input.KeyCode.Name:lower()
		
		if key=="leftshift" or (key=="w" and not uis:IsKeyDown(Enum.KeyCode.LeftShift)) then
			char:setsprint(false)
		end
		
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			-- something?
		elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
			--hmm
		end
	end)

	input.controller:map("a","space")
	input.controller:map("x","r")
	--input.controller:map("l1","leftshift")
	input.controller:map("r1","g")
	input.controller:map("up","h")
	input.controller:map("r3","f")
	input.controller:map("right","v")
	input.controller:map("down","e")
end



task.wait(3)
table.insert(EVILCONNECTIONS, game.Players.LocalPlayer.CharacterAdded:Connect(KillConnections))
