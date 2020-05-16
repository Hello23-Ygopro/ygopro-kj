--Blaze Helix
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--choose one (banish or get ability)
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1)
end
--choose one (banish or get ability)
function scard.banfilter(c)
	return c:IsFaceup() and c:IsHasEffect(EFFECT_BLOCKER) and c:KJIsBanishable()
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local b1=Duel.IsExistingMatchingCard(scard.banfilter,tp,0,LOCATION_BZONE,1,nil)
	local b2=Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_BZONE,0,1,nil)
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
		local g=Duel.GetMatchingGroup(scard.banfilter,tp,0,LOCATION_BZONE,nil)
		Duel.KJBanish(g,REASON_EFFECT)
	elseif opt==2 then
		local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
		if g:GetCount()==0 then return end
		for tc in aux.Next(g) do
			--attack untapped
			aux.AddTempEffectCustom(e:GetHandler(),tc,3,EFFECT_ATTACK_UNTAPPED)
		end
	end
end
