--Ragefire Tatsurion
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ARMORED_DRAGON,RACE_BEAST_KIN)
	aux.AddRaceCategory(c,RACECAT_DRAGON)
	aux.AddNameCategory(c,NAMECAT_TATSURION)
	--creature
	aux.EnableCreatureAttribute(c)
	--powerful attack
	aux.EnablePowerfulAttack(c,3000,aux.NoHandCondition(PLAYER_SELF))
	aux.AddEffectDescription(c,0,aux.NoHandCondition(PLAYER_SELF))
	--double breaker
	aux.EnableBreaker(c,EFFECT_DOUBLE_BREAKER,aux.NoHandCondition(PLAYER_SELF))
	aux.AddEffectDescription(c,1,aux.NoHandCondition(PLAYER_SELF))
	--cannot be targeted
	aux.EnableCannotBeTargeted(c,aux.NoHandCondition(PLAYER_SELF))
	aux.AddEffectDescription(c,2,aux.NoHandCondition(PLAYER_SELF))
end
