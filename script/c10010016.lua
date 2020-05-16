--Ravenous Web-Leg
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SHADOW_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--guard
	aux.EnableGuard(c)
	--banish
	aux.EnableBattleWinSelfBanish(c)
	--banish
	aux.AddSingleTriggerEffect(c,0,EVENT_BANISHED,nil,nil,aux.BanishOperation(PLAYER_OPPO,Card.IsFaceup,0,LOCATION_BZONE,1))
end
