--Shouter, Paragon of Nature
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,scard.op1,nil,scard.con1)
end
--get ability
scard.con1=aux.ExistingCardCondition(Card.IsFaceup,LOCATION_BZONE,0,5)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_BZONE,0,nil)
	if g:GetCount()==0 then return end
	local c=e:GetHandler()
	for tc in aux.Next(g) do
		--power up
		aux.AddTempEffectUpdatePower(c,tc,1,5000)
		--break extra shield
		aux.AddTempEffectCustom(c,tc,2,EFFECT_BREAK_EXTRA_SHIELD)
	end
end
