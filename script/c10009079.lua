--Skaak the Stinger
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA,RACE_MEGABUG)
	--creature
	aux.EnableCreatureAttribute(c)
	--discard
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,aux.HintTarget,aux.DiscardOperation(PLAYER_OPPO,aux.TRUE,0,LOCATION_HAND,1))
	--to mana zone
	aux.AddSingleTriggerEffect(c,1,EVENT_COME_INTO_PLAY,nil,aux.HintTarget,scard.op1)
end
--to mana zone
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerCanSendDecktoMZone(tp,1) and Duel.SelectYesNo(tp,YESNOMSG_TOMZONE) then
		Duel.SendDecktoMZone(tp,1,POS_FACEUP_UNTAPPED,REASON_EFFECT)
	end
end
