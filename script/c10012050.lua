--Verdant Helix
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--choose one (to mana zone or return)
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1)
end
--choose one (to mana zone or return)
function scard.thfilter(c)
	return c:IsCreature() and c:IsAbleToHand()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local b1=Duel.IsPlayerCanSendDecktoptoMZone(tp,1)
	local b2=Duel.IsExistingMatchingCard(aux.ManaZoneFilter(scard.thfilter),tp,LOCATION_MZONE,0,1,nil)
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
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	if opt==1 then
		Duel.SendDecktoptoMZoneUpTo(tp,2,POS_FACEUP_UNTAPPED,REASON_EFFECT)
	elseif opt==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
		local g=Duel.SelectMatchingCard(tp,aux.ManaZoneFilter(scard.thfilter),tp,LOCATION_MZONE,0,0,2,nil)
		if g:GetCount()==0 then return end
		Duel.SendtoHand(g,PLAYER_OWNER,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
