--Reef Prince Glu-urrgle
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD)
	aux.AddNameCategory(c,NAMECAT_GLUURRGLE)
	--creature
	aux.EnableCreatureAttribute(c)
	--to hand
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,aux.DecktopSendtoHandOperation(PLAYER_SELF,nil,4,0,1,SEQ_DECK_BOTTOM))
end
