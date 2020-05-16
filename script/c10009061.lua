--Krazzix the Volatile
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_RIPTIDE_CHAMPION,RACE_BLAZE_CHAMPION)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--get ability
	aux.AddTriggerEffect(c,0,EVENT_DRAW,nil,nil,scard.op1,nil,aux.EventPlayerCondition(PLAYER_SELF))
	--triple breaker
	aux.EnableBreaker(c,EFFECT_TRIPLE_BREAKER,scard.con2)
	aux.AddEffectDescription(c,2,scard.con2)
end
--get ability
function scard.op1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	for i=1,eg:GetCount() do
		--powerful attack
		aux.AddTempEffectPowerfulAttack(c,c,1,2000)
	end
end
--triple breaker
function scard.con2(e)
	return e:GetHandler():IsPowerAbove(12000)
end
