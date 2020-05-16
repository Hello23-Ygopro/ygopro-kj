--Sasha, Channeler of Light
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ANGEL_COMMAND)
	--creature
	aux.EnableCreatureAttribute(c)
	--to deck
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--to deck
function scard.tdfilter(c)
	return c:IsFaceup() and c:IsTapped() and c:IsAbleToDeck()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.tdfilter,0,LOCATION_BZONE,0,2,HINTMSG_TODECK)
scard.op1=aux.TargetCardsOperation(Duel.SendtoDeck,SEQ_DECK_SHUFFLE)
