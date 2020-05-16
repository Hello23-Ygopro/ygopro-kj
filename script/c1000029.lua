--Ba'kaar Frostwing
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TSUNAMI_DRAGON,RACE_EARTHSTRIKE_DRAGON)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	--creature
	aux.EnableCreatureAttribute(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--cannot be blocked
	aux.EnableCannotBeBlocked(c,aux.CannotBeBlockedLessPowerValue)
	--draw
	aux.AddSingleTriggerEffectWinBattle(c,0,true,aux.DrawTarget(PLAYER_SELF),aux.DrawOperation(PLAYER_SELF,2))
end
