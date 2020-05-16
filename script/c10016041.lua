--Blazing Skyrider Valko
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_BURN_BELLY)
	aux.AddNameCategory(c,NAMECAT_VALKO)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1,nil,scard.con1)
end
--get ability
function scard.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_BZONE,0,2,e:GetHandler())
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--fast attack
	aux.AddTempEffectCustom(c,c,1,EFFECT_FAST_ATTACK)
end
