--Jarbala Hatchery
local scard,sid=aux.GetID()
function scard.initial_effect(c)
	aux.AddRace(c,RACE_LIVING_CITY)
	--creature
	aux.EnableCreatureAttribute(c)
	--cost down
	aux.EnableUpdatePlayCost(c,-2,nil,LOCATION_ALL,0,scard.tg1)
	if not scard.global_check then
		scard.global_check=true
		scard[0]=0
		scard[1]=0
		--check summoned creature
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_COME_INTO_PLAY)
		ge1:SetOperation(scard.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(scard.clearop)
		Duel.RegisterEffect(ge2,0)
	end
end
--check summoned creature
function scard.cfilter(c)
	return c:IsFaceup() and c:GetSummonType()==SUMMON_TYPE_NONEVOLVE
end
function scard.checkop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(scard.cfilter,nil)
	if g:GetCount()==0 then return end
	for tc in aux.Next(g) do
		scard[tc:GetSummonPlayer()]=scard[tc:GetSummonPlayer()]+1
	end
end
function scard.clearop(e,tp,eg,ep,ev,re,r,rp)
	scard[0]=0
	scard[1]=0
end
--cost down
function scard.tg1(e,c)
	return c:IsCreature() and scard[c:GetControler()]==1
end
--[[
	Rulings
	Q: If Jarbala Hatchery is the first creature I summon in a turn, does "Abounding Essence" apply to the next creature
	I summon?
		A: Yes. That creature will be the second creature you summon that turn. The ability will consider the entire turn,
		even if Jarbala Hatchery wasn't in the battle zone for part of that turn.
	https://kaijudo.fandom.com/wiki/Jarbala_Hatchery/Rulings
]]
