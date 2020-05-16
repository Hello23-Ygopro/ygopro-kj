--Reflector Cannon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_FRACTAL)
	--creature
	aux.EnableCreatureAttribute(c)
	--tap
	aux.AddSingleTriggerEffect(c,0,EVENT_BANISHED,nil,nil,aux.TapOperation(nil,Card.IsFaceup,0,LOCATION_BZONE))
end
