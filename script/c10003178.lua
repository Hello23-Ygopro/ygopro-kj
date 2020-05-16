--Bestial Rage Tatsurion
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON,RACE_BEAST_KIN)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	aux.AddNameCategory(c,NAMECAT_TATSURION)
	--creature
	aux.EnableCreatureAttribute(c)
	--powerful attack
	aux.EnablePowerfulAttack(c,3000)
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER)
	--break
	aux.AddSingleTriggerEffectWinBattle(c,0,nil,nil,aux.BreakOperation(PLAYER_SELF,PLAYER_OPPO,1,1,c))
end
