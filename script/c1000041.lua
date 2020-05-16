--Wavebreaker Shaman
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_AQUAN,RACE_SPIRIT_TOTEM)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--guard
	aux.EnableGuard(c)
	--confirm deck (to hand)
	aux.AddSingleTriggerEffect(c,0,EVENT_CUSTOM+EVENT_BLOCK,nil,nil,scard.op1)
end
--confirm deck (to hand)
scard.op1=aux.DecktopSendtoHandOperation(PLAYER_SELF,Card.IsCreature,3,0,1,SEQ_DECK_BOTTOM,nil,true)
