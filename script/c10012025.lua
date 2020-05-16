--Nightmare Helix
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--choose one (banish or return)
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1)
end
--choose one (banish or return)
function scard.banfilter(c)
	return c:IsFaceup() and c:IsUntapped() and c:KJIsBanishable()
end
function scard.retfilter(c)
	return c:IsCreature() and c:IsAbleToHand()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local b1=Duel.IsExistingTarget(scard.banfilter,tp,0,LOCATION_BZONE,1,nil)
	local b2=Duel.IsExistingMatchingCard(aux.KJDPileFilter(scard.retfilter),tp,LOCATION_DPILE,0,1,nil)
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
	e:SetProperty(0)
	if opt==1 then
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISH)
		Duel.SelectTarget(tp,scard.banfilter,tp,0,LOCATION_BZONE,1,1,nil)
	end
	e:SetLabel(opt)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	if opt==1 then
		local tc=Duel.GetFirstTarget()
		if tc and tc:IsRelateToEffect(e) and scard.banfilter(tc) then
			Duel.KJBanish(tc,REASON_EFFECT)
		end
	elseif opt==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
		local g=Duel.SelectMatchingCard(tp,aux.KJDPileFilter(scard.retfilter),tp,LOCATION_DPILE,0,0,2,nil)
		if g:GetCount()==0 then return end
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
