--Mark of Almighty Colossus
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--choose one (to battle or get ability, do battle)
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1)
end
--choose one (to battle or get ability, do battle)
function scard.tbfilter(c,e,tp)
	return c:IsCode(CARD_ALMIGHTY_COLOSSUS) and c:IsAbleToBZone(e,0,tp,false,false)
end
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local b1=Duel.IsExistingMatchingCard(scard.tbfilter,tp,LOCATION_HAND,0,1,nil,e,tp)
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
	e:SetProperty(0)
	if opt==2 then
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
	end
	e:SetLabel(opt)
end
function scard.batfilter(c,e)
	return c:IsFaceup() and c:IsCanBeEffectTarget(e)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	if opt==1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOBZONE)
		local g=Duel.SelectMatchingCard(tp,scard.tbfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
		Duel.SendtoBZone(g,0,tp,tp,false,false,POS_FACEUP_UNTAPPED)
	elseif opt==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
		local tc1=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,1,1,nil):GetFirst()
		if not tc1 then return end
		Duel.HintSelection(Group.FromCards(tc1))
		--power up
		aux.AddTempEffectUpdatePower(e:GetHandler(),tc1,3,3000)
		--do battle
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local tc2=Duel.SelectMatchingCard(tp,scard.batfilter,tp,0,LOCATION_BZONE,1,1,nil,e):GetFirst()
		if not tc1 or not tc1:IsFaceup() or not tc2 then return end
		Duel.SetTargetCard(tc2)
		Duel.DoBattle(tc1,tc2)
	end
end
