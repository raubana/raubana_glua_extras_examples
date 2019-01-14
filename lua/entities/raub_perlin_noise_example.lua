AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.PrintName		= "Perlin Noise"
ENT.Author			= "Raubana"
ENT.Information		= "A globe that emits light. The light use perlin noise so it looks like a fire."
ENT.Category		= "Raubana GLua Extras Examples"

ENT.Editable		= true
ENT.Spawnable		= true
ENT.AdminOnly		= true
ENT.RenderGroup		= RENDERGROUP_OPAQUE




function ENT:Initialize()
	self:SetModel( "models/props_combine/breenglobe.mdl" )
	
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
	end
	
	if CLIENT then
		self.perlin_noise = PERLIN_NOISE_GEN:create( 10, 0.25, 3 )
	end
end




if CLIENT then
	function ENT:Think()
		local curtime = CurTime()
		local realtime = RealTime()
	
		local brightness = self.perlin_noise:gen( realtime )
		
		local dlight = DynamicLight( self:EntIndex() )
		if dlight then
			dlight.pos = self:GetPos()
			dlight.r = 255*brightness
			dlight.g = 128*brightness
			dlight.b = 0
			dlight.brightness = 8
			dlight.Decay = 500
			dlight.Size = 128
			dlight.DieTime = curtime + 1.0
		end
		
		self:SetNextClientThink(curtime)
		return true
	end
end