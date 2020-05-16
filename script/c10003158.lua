--Shell Dome
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIVING_CITY)
	--creature
	aux.EnableCreatureAttribute(c)
	--to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.SendtoMZoneOperation(PLAYER_OPPO,Card.IsFaceup,0,LOCATION_BZONE,1))
end
