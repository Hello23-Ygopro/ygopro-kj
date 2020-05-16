--Spellbane Dragon
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--break
	aux.AddTriggerEffectPlayerCastSpell(c,0,PLAYER_OPPO,nil,nil,nil,aux.BreakOperation(PLAYER_SELF,PLAYER_OPPO,1,1,c))
end
