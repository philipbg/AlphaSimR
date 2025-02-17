context("crossing")

founderPop = newMapPop(list(c(0)),
                       list(matrix(c(1,1,0,0),
                                   nrow=4,ncol=1)))

test_that("makeCross",{
  SP = SimParam$new(founderPop=founderPop)
  SP$addTraitA(nQtlPerChr=1,mean=0,var=1)
  SP$setTrackPed(TRUE)
  pop = newPop(founderPop,simParam=SP)
  crossPlan = cbind(rep(1,10),rep(2,10))
  #Match by number
  pop1 = makeCross(pop=pop,crossPlan=crossPlan,simParam=SP)
  expect_equal(SP$lastId,12L)
  expect_equal(unname(meanG(pop1)),0,tolerance=1e-6)
  expect_equal(unname(SP$pedigree[-(1:2),1L]),rep(1L,10L))
  expect_equal(unname(SP$pedigree[-(1:2),2L]),rep(2L,10L))
  #Match by id
  crossPlan = matrix(as.character(crossPlan),ncol=2)
  pop2 = makeCross(pop=pop,crossPlan=crossPlan,simParam=SP)
  expect_equal(SP$lastId,22L)
  expect_equal(unname(meanG(pop2)),0,tolerance=1e-6)
  expect_equal(unname(SP$pedigree[-(1:2),1L]),rep(1L,20L))
  expect_equal(unname(SP$pedigree[-(1:2),2L]),rep(2L,20L))
})

test_that("makeCross2",{
  SP = SimParam$new(founderPop=founderPop)
  SP$addTraitA(nQtlPerChr=1,mean=0,var=1)
  SP$setTrackPed(TRUE)
  pop = newPop(founderPop,simParam=SP)
  crossPlan = cbind(rep(1,10),rep(2,10))
  #Match by number
  pop1 = makeCross2(females=pop,males=pop,crossPlan=crossPlan,simParam=SP)
  expect_equal(SP$lastId,12L)
  expect_equal(unname(meanG(pop1)),0,tolerance=1e-6)
  expect_equal(unname(SP$pedigree[-(1:2),1L]),rep(1L,10L))
  expect_equal(unname(SP$pedigree[-(1:2),2L]),rep(2L,10L))
  #Match by id
  crossPlan = matrix(as.character(crossPlan),ncol=2)
  pop2 = makeCross2(females=pop,males=pop,crossPlan=crossPlan,simParam=SP)
  expect_equal(SP$lastId,22L)
  expect_equal(unname(meanG(pop2)),0,tolerance=1e-6)
  expect_equal(unname(SP$pedigree[-(1:2),1L]),rep(1L,20L))
  expect_equal(unname(SP$pedigree[-(1:2),2L]),rep(2L,20L))
})

test_that("randCross",{
  SP = SimParam$new(founderPop=founderPop)
  SP$addTraitA(nQtlPerChr=1,mean=0,var=1)
  SP$setTrackPed(TRUE)
  SP$setSexes("yes_sys")
  pop = newPop(founderPop,simParam=SP)
  crossPlan = cbind(rep(1,10),rep(2,10))
  pop1 = randCross(pop=pop,nCrosses=1,nProgeny=10,simParam=SP)
  expect_equal(SP$lastId,12L)
  expect_equal(unname(meanG(pop1)),0,tolerance=1e-6)
  expect_equal(unname(SP$pedigree[-(1:2),1L]),rep(2L,10L))
  expect_equal(unname(SP$pedigree[-(1:2),2L]),rep(1L,10L))
})

test_that("randCross2",{
  SP = SimParam$new(founderPop=founderPop)
  SP$addTraitA(nQtlPerChr=1,mean=0,var=1)
  SP$setTrackPed(TRUE)
  SP$setSexes("yes_sys")
  pop = newPop(founderPop,simParam=SP)
  crossPlan = cbind(rep(1,10),rep(2,10))
  pop1 = randCross2(females=pop,males=pop,nCrosses=1,nProgeny=10,simParam=SP)
  expect_equal(SP$lastId,12L)
  expect_equal(unname(meanG(pop1)),0,tolerance=1e-6)
  expect_equal(unname(SP$pedigree[-(1:2),1L]),rep(2L,10L))
  expect_equal(unname(SP$pedigree[-(1:2),2L]),rep(1L,10L))
})

test_that("self",{
  SP = SimParam$new(founderPop=founderPop)
  SP$addTraitA(nQtlPerChr=1,mean=0,var=1)
  SP$setTrackPed(TRUE)
  pop = newPop(founderPop,simParam=SP)
  crossPlan = cbind(rep(1,10),rep(2,10))
  pop1 = self(pop=pop,nProgeny=1,simParam=SP)
  expect_equal(SP$lastId,4L)
  expect_equal(unname(meanG(pop1)),0,tolerance=1e-6)
  expect_equal(unname(SP$pedigree[-(1:2),1L]),c(1L,2L))
  expect_equal(unname(SP$pedigree[-(1:2),2L]),c(1L,2L))
  expect_equal(unname(SP$pedigree[-(1:2),3L]),c(0L,0L))
})

test_that("makeDH",{
  SP = SimParam$new(founderPop=founderPop)
  SP$addTraitA(nQtlPerChr=1,mean=0,var=1)
  SP$setTrackPed(TRUE)
  pop = newPop(founderPop,simParam=SP)
  crossPlan = cbind(rep(1,10),rep(2,10))
  pop1 = makeDH(pop=pop,nDH=1,simParam=SP)
  expect_equal(SP$lastId,4L)
  expect_equal(unname(meanG(pop1)),0,tolerance=1e-6)
  expect_equal(unname(SP$pedigree[-(1:2),1L]),c(1L,2L))
  expect_equal(unname(SP$pedigree[-(1:2),2L]),c(1L,2L))
  expect_equal(unname(SP$pedigree[-(1:2),3L]),c(1L,1L))
})

test_that("selectCross",{
  SP = SimParam$new(founderPop=founderPop)
  SP$addTraitA(nQtlPerChr=1,mean=0,var=1)
  SP$setTrackPed(TRUE)
  SP$setSexes("yes_sys")
  pop = newPop(founderPop,simParam=SP)
  pop1 = selectCross(pop=pop,nFemale=1,nMale=1,use="rand",nCrosses=2,simParam=SP)
  expect_equal(SP$lastId,4L)
  expect_equal(unname(meanG(pop1)),0,tolerance=1e-6)
  expect_equal(unname(SP$pedigree[-(1:2),1L]),c(2L,2L))
  expect_equal(unname(SP$pedigree[-(1:2),2L]),c(1L,1L))
})

test_that("selectOP",{
  SP = SimParam$new(founderPop=founderPop)
  SP$addTraitA(nQtlPerChr=1,mean=0,var=1)
  SP$setTrackPed(TRUE)
  pop = newPop(founderPop,simParam=SP)
  pop1 = selectOP(pop=pop,nInd=1,nSeeds=2,use="gv",simParam=SP)
  expect_equal(SP$lastId,4L)
  expect_equal(unname(meanG(pop1)),0,tolerance=1e-6)
  tmp = abs(SP$pedigree[-(1:2),1L]-SP$pedigree[-(1:2),2L])
  expect_equal(unname(tmp),c(1L,1L))
})
