--Sledgefoot
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_TREE_KIN)
	--creature
	aux.EnableCreatureAttribute(c)
	--skirmisher
	aux.EnableSkirmisher(c)
	--break
	aux.AddSingleTriggerEffectWinBattle(c,0,nil,nil,aux.BreakOperation(PLAYER_SELF,PLAYER_OPPO,2,2,c))
end
