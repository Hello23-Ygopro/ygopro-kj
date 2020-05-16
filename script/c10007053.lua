--Mark of Infernus
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--choose one (to battle or banish)
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1)
end
--choose one (to battle or banish)
function scard.tbfilter(c,e,tp)
	return c:IsCode(CARD_INFERNUS_THE_IMMOLATOR) and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.banfilter1(c)
	return c:IsFaceup() and c:IsPowerBelow(5000) and c:KJIsBanishable()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local b1=Duel.IsExistingMatchingCard(scard.tbfilter,tp,LOCATION_HAND,0,1,nil,e,tp)
	local b2=Duel.IsExistingTarget(scard.banfilter1,tp,0,LOCATION_BZONE,1,nil)
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
	if opt==2 then
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
	end
	e:SetLabel(opt)
end
function scard.banfilter2(c,e,pwr)
	return c:IsFaceup() and c:IsPowerAbove(0) and c:IsPowerBelow(pwr) and c:KJIsBanishable() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	if opt==1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
		local g=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
		Duel.SendtoBZone(g,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
	elseif opt==2 then
		local pwr=5000
		local g=Duel.GetMatchingGroup(scard.banfilter2,tp,0,LOCATION_BZONE,nil,e,pwr)
		local bg=Group.CreateGroup()
		repeat
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_BANISH)
			local tc=g:Select(tp,0,1,nil):GetFirst()
			if not tc then break end
			Duel.HintSelection(Group.FromCards(tc))
			bg:AddCard(tc)
			pwr=pwr-tc:GetPower()
			g=g:Filter(scard.banfilter2,nil,e,pwr)
		until pwr<=0 or g:GetCount()==0
		Duel.KJBanish(bg,REASON_EFFECT)
	end
end
--[[
	References
		1. Ninjitsu Art of Duplication
		https://github.com/Fluorohydride/ygopro-scripts/blob/db63e8c/c50766506.lua#L41
]]
