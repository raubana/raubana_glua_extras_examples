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
	local radius = 85
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