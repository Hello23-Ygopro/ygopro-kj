--Writhing Bone Ghoul
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_ZOMBIE)
	--creature
	aux.EnableCreatureAttribute(c)
end
