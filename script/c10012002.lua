--Beacon Drone
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_STORM_PATROL)
	--creature
	aux.EnableCreatureAttribute(c)
	--untap
	aux.AddSingleTriggerEffect(c,0,EVENT_BANISHED,nil,nil,aux.UntapOperation(PLAYER_SELF,Card.IsFaceup,LOCATION_BZONE,0,1))
end
