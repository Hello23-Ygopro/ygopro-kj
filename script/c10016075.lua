--Cybear
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_CYBER_LORD,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--choose one (get ability)
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,scard.tg1,scard.op1)
end
--choose one (get ability)
function scard.tg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local b1=Duel.IsExistingMatchingCard(aux.Card.IsFaceup,tp,LOCATION_BZONE,0,1,nil)
	local b2=Duel.IsExistingMatchingCard(aux.Card.IsFaceup,tp,LOCATION_BZONE,0,1,e:GetHandler())
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
	local c=e:GetHandler()
	if opt==1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
		local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,1,1,nil)
		if g:GetCount()==0 then return end
		Duel.HintSelection(g)
		--cannot be blocked
		aux.AddTempEffectCannotBeBlocked(c,g:GetFirst(),3)
	elseif opt==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CREATURE)
		local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_BZONE,0,1,1,c)
		if g:GetCount()==0 then return end
		Duel.HintSelection(g)
		--power up
		aux.AddTempEffectUpdatePower(c,g:GetFirst(),4,3000)
	end
end
