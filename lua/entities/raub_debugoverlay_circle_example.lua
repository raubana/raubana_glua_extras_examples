AddCSLuaFile()

DEFINE_BASECLASS( "base_anim" )

ENT.PrintName		= "debugoverlay.Circle"
ENT.Author			= "Raubana"
ENT.Information		= "A ball that draws a circle around its circumference."
ENT.Category		= "Raubana GLua Extras Examples"

ENT.Editable		= true
ENT.Spawnable		= true
ENT.AdminOnly		= true
ENT.RenderGroup		= RENDERGROUP_OPAQUE




local radius = 90

function ENT:Initialize()
	self:SetModel( "models/hunter/misc/sphere375x375.mdl" )
	
	if SERVER then
		self:PhysicsInitSphere(radius, "metal")
		self:SetCollisionBounds(Vector(1,1,1)*-(radius+5), Vector(1,1,1)*(radius+5))
		local phys = self:GetPhysicsObject()
		phys:SetMass(100)
		phys:EnableMotion(true)
		phys:Wake()
		phys:EnableDrag(false)
	end
end




if SERVER then

	function ENT:Think()
		if not debugoverlay.Circle then return end
		
		local pos = self:GetPos()
		local ang = self:GetAngles()
		
		debugoverlay.Circle(
			pos,
			ang,
			radius,
			engine.TickInterval() * 2,
			HSVToColor(
				(CurTime()%1.0)*360,
				1.0,
				1.0
			),
			true
		)
		
		self:NextThink( CurTime() )
		return true
	end
	
end