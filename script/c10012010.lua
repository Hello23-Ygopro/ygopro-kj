--Solar Helix
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	--spell
	aux.EnableSpellAttribute(c)
	--choose one (tap or get ability)
	aux.AddSpellCastEffect(c,0,scard.tg1,scard.op1)
end
--choose one (tap or get ability)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local b1=Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_BZONE,1,nil)
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
	if opt==1 then
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_BZONE,1,1,nil)
	end
	e:SetLabel(opt)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local opt=e:GetLabel()
	if opt==1 then
		local tc=Duel.GetFirstTarget()
		if not tc or not tc:IsRelateToEffect(e) or not tc:IsFaceup() then return end
		Duel.Tap(tc,REASON_EFFECT)
		local reset_count=(Duel.GetTurnPlayer()~=tp and 2 or 1)
		--do not untap
		aux.AddTempEffectCustom(e:GetHandler(),tc,3,EFFECT_DONOT_UNTAP_START_STEP,RESET_PHASE+PHASE_DRAW,reset_count)
	elseif opt==2 then
		local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
		if g:GetCount()==0 then return end
		local reset_count=(Duel.GetTurnPlayer()==tp and 2 or 1)
		for tc in aux.Next(g) do
			--blocker
			aux.AddTempEffectBlocker(e:GetHandler(),tc,4,RESET_PHASE+PHASE_DRAW,reset_count)
		end
	end
end
