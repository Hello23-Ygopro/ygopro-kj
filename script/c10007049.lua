--Flame Spinner
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DRAKON)
	--creature
	aux.EnableCreatureAttribute(c)
	--get ability
	aux.AddSingleTriggerEffect(c,0,EVENT_COME_INTO_PLAY,nil,nil,scard.op1,nil,aux.ExistingCardCondition(scard.cfilter))
end
--get ability
function scard.cfilter(c)
	return c:IsFaceup() and c:IsHasEffect(EFFECT_FAST_ATTACK)
end
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--fast attack
	aux.AddTempEffectCustom(c,c,1,EFFECT_FAST_ATTACK)
end
