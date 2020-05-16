--Darkwood Tribe
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ROT_WORM,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--choose one (get ability or to mana zone)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1)
end
--choose one (get ability or to mana zone)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local b1=Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_BZONE,1,nil)
	local b2=Duel.IsExistingMatchingCard(Card.IsAbleToMZone,tp,LOCATION_HAND,0,1,nil)
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
		if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
			--power down
			aux.AddTempEffectUpdatePower(e:GetHandler(),tc,3,-1000)
		end
	elseif opt==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOMZONE)
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToMZone,tp,LOCATION_HAND,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoMZone(g,POS_FACEUP_UNTAPPED,REASON_EFFECT)
		end
	end
end
