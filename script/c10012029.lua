--The Mystic of Darkness
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_MYSTIC)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddTriggerEffectPlayerCastSpell(c,0,PLAYER_SELF,scard.abfilter,nil,nil,scard.op1)
end
--get ability
scard.abfilter=aux.FilterBoolFunction(Card.IsCivilization,CIVILIZATION_DARKNESS)
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_BZONE,nil)
	if g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		--power down
		aux.AddTempEffectUpdatePower(e:GetHandler(),tc,1,-2000)
	end
end
