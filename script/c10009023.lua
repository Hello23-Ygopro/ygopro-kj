--Mark of Kalima
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--choose one (to battle or to discard pile, banish)
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1)
end
--choose one (to battle or to discard pile, banish)
function scard.tbfilter(c,e,tp)
	return c:IsCode(CARD_QUEEN_KALIMA) and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local b1=Duel.IsExistingMatchingCard(scard.tbfilter,tp,LOCATION_HAND,0,1,nil,e,tp)
	local b2=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
	local option_list={}
	local t={}
	if b1 then
		table.insert(option_list,aux.Stringid(sid,1))
		table.insert(t,1)
	end
	if b2 then
		table.insert(option_list,aux.Stringid(sid,2))
		table.insert(t,2)
	end
	local opt=t[Duel.SelectOption(tp,table.unpack(option_list))+1]
	e:SetLabel(opt)
end
function scard.banfilter(c)
	return c:IsFaceup() and c:KJIsBanishable()
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	if opt==1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
		local g=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
		Duel.SendtoBZone(g,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
	elseif opt==2 then
		local g1=Duel.GetDecktopGroup(tp,2)
		Duel.DisableShuffleCheck()
		Duel.KJSendtoDPile(g1,REASON_EFFECT)
		local ct=g1:FilterCount(aux.KJDPileFilter(Card.IsCivilization),nil,CIVILIZATION_DARKNESS)
		if ct==0 then return end
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_BANISH)
		local g2=Duel.SelectMatchingCard(1-tp,scard.banfilter,1-tp,LOCATION_BZONE,0,ct,ct,nil)
		if g2:GetCount()==0 then return end
		Duel.HintSelection(g2)
		Duel.KJBanish(g2,REASON_EFFECT)
	end
end
