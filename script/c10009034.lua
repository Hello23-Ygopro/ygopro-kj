--Headstrong Wanderer
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_ATTACK_ANNOUNCE,nil,nil,scard.op1)
end
--get ability
function scard.powfilter(c)
	return c:IsFaceup() and c:KJIsRace(RACE_BEAST_KIN)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(scard.powfilter,tp,LOCATION_BZONE,0,c)
	if g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		--power up
		aux.AddTempEffectUpdatePower(c,tc,1,2000)
	end
end
