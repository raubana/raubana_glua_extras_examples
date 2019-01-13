AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.PrintName		= "debugoverlay.Node"
ENT.Author			= "Raubana"
ENT.Information		= "A ball that draws a cube ahead of its position based on its velocity."
ENT.Category		= "Raubana GLua Extras Examples"

ENT.Editable		= true
ENT.Spawnable		= true
ENT.AdminOnly		= true
ENT.RenderGroup		= RENDERGROUP_OPAQUE




function ENT:Initialize()
	self:SetModel( "models/Combine_Helicopter/helicopter_bomb01.mdl" )
	
	if SERVER then
		self:PhysicsInit(SOLID_VPHYSICS)
	end
end




if SERVER then

	function ENT:Think()
		if not debugoverlay.Node then return end
		
		local pos = self:GetPos()
		local vel = self:GetVelocity()
		
		debugoverlay.Node(
			pos + (vel),
			20,
			engine.TickInterval() * 2,
			HSVToColor(
				(CurTime()%1.0)*360,
				1.0,
				1.0
			)
		)
		
		self:NextThink( CurTime() )
		return true
	end
	
end