--Lurking Skull Cutter
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_DREAD_MASK)
	--creature
	aux.EnableCreatureAttribute(c)
	--slayer
	aux.EnableSlayer(c,aux.SelfAttackerCondition)
	aux.AddEffectDescription(c,0,aux.SelfAttackerCondition)
end
