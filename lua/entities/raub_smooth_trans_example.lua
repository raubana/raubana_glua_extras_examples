AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.PrintName		= "Smooth Transition"
ENT.Author			= "Raubana"
ENT.Information		= "A globe that changes color depending on how close the local player is."
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
		self.smooth_trans = SMOOTH_TRANS:create( 2 )
	end
end




if CLIENT then
	function ENT:Think()
		local localplayer = LocalPlayer()
		if not IsValid( localplayer ) then return end
	
		local curtime = CurTime()
	
		local player_is_too_close = localplayer:GetPos():Distance( self:GetPos() ) <= 200
	
		self.smooth_trans:SetDirection( not player_is_too_close )
		self.smooth_trans:Update()
		
		local p = self.smooth_trans:GetPercent()
		
		local dlight = DynamicLight( self:EntIndex() )
		if dlight then
			dlight.pos = self:GetPos()
			dlight.r = 255
			dlight.g = 255*(1-p)
			dlight.b = 255*p
			dlight.brightness = 5
			dlight.Decay = 500
			dlight.Size = 128
			dlight.DieTime = curtime + 1.0
		end
		
		self:SetNextClientThink(curtime)
		return true
	end
end