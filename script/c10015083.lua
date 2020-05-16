--Shredmane
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CHIMERA)
	--creature
	aux.EnableCreatureAttribute(c)
	--choose one (get ability)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1)
end
--choose one (get ability)
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
		--power down
		aux.AddTempEffectUpdatePower(e:GetHandler(),tc,3,-2000)
	elseif opt==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
		local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,1,1,nil)
		if g:GetCount()==0 then return end
		Duel.HintSelection(g)
		--slayer
		aux.AddTempEffectSlayer(e:GetHandler(),g:GetFirst(),4)
	end
end
