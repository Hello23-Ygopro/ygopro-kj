--Guardian Akhal-Teek
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_SKYFORCE_CHAMPION,RACE_BEAST_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--blocker
	aux.EnableBlocker(c)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--break
	aux.AddSingleTriggerEffectWinBattle(c,0,nil,nil,aux.BreakOperation(PLAYER_SELF,PLAYER_OPPO,2,2,c))
end
