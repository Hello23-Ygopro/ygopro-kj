--Crystalize
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--shield blast
	aux.EnableShieldBlast(c)
	--return, to mana zone
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1,EFFECT_FLAG_CARD_TARGET)
end
--return, to mana zone
function scard.thfilter(c)
	return c:IsFaceup() and c:IsAbleToHand()
end
scard.tg1=aux.TargetCardFunction(PLAYER_SELF,scard.thfilter,LOCATION_BZONE,LOCATION_BZONE,1,1,HINTMSG_RTOHAND)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local shuffle_hand=false
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and scard.thfilter(tc) then
		if Duel.SendtoHand(tc,PLAYER_OWNER,REASON_EFFECT)>0 then shuffle_hand=true end
	end
	local p=tc:GetControler()
	if shuffle_hand then Duel.ShuffleHand(p) end
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TOMZONE)
	local g=Duel.SelectMatchingCard(p,Card.IsAbleToMZone,p,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()==0 then return end
	Duel.BreakEffect()
	Duel.SendtoMZone(g,POS_FACEUP_UNTAPPED,REASON_EFFECT)
end
