--Ethereal Agent
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_VIRUS)
	--creature
	aux.EnableCreatureAttribute(c)
	--confirm shield
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.ConfirmOperation(PLAYER_SELF,aux.ShieldZoneFilter(Card.IsFacedown),0,LOCATION_SZONE,1))
	--cannot be blocked
	aux.EnableCannotBeBlocked(c)
	--draw
	aux.AddSingleTriggerEffect(c,1,EVENT_ATTACK_ANNOUNCE,true,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,1))
end
