--Johnny Darkseed
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_EVIL_TOY,RACE_TREE_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--banish, to mana zone
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,true,scard.tg1,scard.op1)
end
--banish, to mana zone
function scard.banfilter(c)
	return c:IsFaceup() and c:KJIsBanishable()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(scard.banfilter,tp,LOCATION_BZONE,0,1,e:GetHandler()) end
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISH)
	local g=Duel.SelectMatchingCard(tp,scard.banfilter,tp,LOCATION_BZONE,0,1,1,e:GetHandler())
	if g:GetCount()==0 then return end
	Duel.HintSelection(g)
	if Duel.KJBanish(g,REASON_EFFECT)>0 then
		Duel.SendDecktoptoMZone(tp,2,POS_FACEUP_TAPPED,REASON_EFFECT)
	end
end
