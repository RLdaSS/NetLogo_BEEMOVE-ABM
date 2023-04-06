;; world: NetLogo world
;; NetLogo world background color has been set to white
;;;; EXTENSIONS ;;;;
extensions [ gis csv vid ]
;;;; GLOBALS ;;;;
;; define global variables
globals [
  Landcover
  LoadSaveDirectoryFolder
  AccumulatedEnergy
  RandomSeeds
  NumLandscapes
  HotPatchSet
  ValidHabs
  ValidHabsItem
  ListProfiles
  PatchAvailable
  EnvironmentalVariation
  CurrentHotPatchSet
  Output1
  Output2
  Output3
  Output4
  Output-Data-1List
  Constance
  ConstanceCounter
  StabilityList
  NInitial
  NFinal
  ListNInitial
  ListNFinal
  ListDeath
  ListBirth
  ListR
  ListTicks
  ColonyMetabolism1
  ColonyMetabolism2
  ColonyMetabolism3
  EnergyReproduction1
  EnergyReproduction2
  EnergyReproduction3
  MinimumEnergy1
  MinimumEnergy2
  MinimumEnergy3
  NumberProfiles ;; count the number of profiles in the interface (monitor)
  ValueDiff ;; used to color patches in reference to accumulated resource
  EqualParts ;; used to color patches in reference to accumulated resource
  SumEqualParts ;; used to color patches in reference to accumulated resource
]
;;;; AGENT DEFINITION ;;;;
;; define agent types
breed [ colonies colony ]
;; define colonies variables ;; declaring all colonies variables
colonies-own
[
  colony-profiles-habitat
  energy-colony
  energy-reproduction
  colony-metabolism
  colony-profiles-code
  colony-met-repro-code-color
  colony-profiles-reproduction-code
  colony-profiles-metabolism-code
  my-patches
  c-p-h-item-ValidHabs
  colony-profiles-habitat-code
  done-output2
  done-output4
]
;; define patches variables ;; declaring all patch variables
patches-own
[
  habitatcover
  accumulated-energy-value
]
;; ===========================================================================
;;;; MODEL SETUP ;;;;
to setup
  clear-all ;; this doesn't clear local variables
  set RandomSeeds 1
  random-seed RandomSeeds
  let start timer ;; start time
  read-legal-habs ;; create list of valid habitats for each colony profile
  ifelse ( Display? = true ) [ display ] [ no-display ]  ;; shut on/off the display to take much  patch-faster to run the code using switch in GUI
  ;; use input "EdgeSize" in inter patch-face of NetLogo
  resize-world EdgeSize * 0 ( EdgeSize * 1 )  ( EdgeSize * -1 ) EdgeSize * 0 ;; defines the edge size of the world and location of origin: corner top left
  set NumLandscapes 1
  set ValidHabsItem 0
  set Constance 1
  set StabilityList [ ]
  set ListProfiles [ ]
  set ListNInitial [ ]
  set ListDeath [ ]
  set ListBirth [ ]
  set ListR [ ]
  set Output-Data-1List [ ]
  set Output1 false
  set Output2 false
  set Output3 false
  set Output4 false
  setup-layers ;; CALL A PROCEDURE
  setup-patches ;; CALL A PROCEDURE
  ListProfilesProc ;; CALL A PROCEDURE
  reset-ticks
  if vid:recorder-status = "recording" [ vid:record-view ]
  let finish timer ;; finish time
 ; print ( word "that setup took " ( finish - start ) " seconds" )
end
to read-legal-habs
  let combination 1
  set ValidHabs [ ]
  while [ combination > 0 and combination < 7 ]
  [
    let hc [ ]
    if combination = 1
    [
      let i 1
      while [ i > 0 and i < 7 ]
      [
        set hc ( list i )
        set i i + 1
        set ValidHabs lput hc ValidHabs
      ]
    ]
    let hc2 [ ]
    if combination = 2
    [
      let i 1
      while [ i > 0 and i < 7 ]
      [
        let j 1
        while [ j > 0 and j < 7 ]
        [
          set hc2 ( list i j )
          if j != i
          [
            set hc2 sort hc2
            set ValidHabs lput hc2 ValidHabs
            set ValidHabs remove-duplicates ValidHabs
          ]
          set j j + 1
        ]
        set i i + 1
      ]
    ]
    let hc3 [ ]
    if combination = 3
    [
      let i 1
      while [ i > 0 and i < 7 ]
      [
        let j 1
        while [ j > 0 and j < 7 ]
        [
          let k 1
          while [ k > 0 and k < 7 ]
          [
            set hc3 ( list i j k )
            if i != j and k != j and k != i
            [
              set hc3 sort hc3
              set ValidHabs lput hc3 ValidHabs
              set ValidHabs remove-duplicates ValidHabs
            ]
            set k k + 1
          ]
          set j j + 1
        ]
        set i i + 1
      ]
    ]
    let hc4 [ ]
    if combination = 4
    [
      let i 1
      while [ i > 0 and i < 7 ]
      [
        let j 1
        while [ j > 0 and j < 7 ]
        [
          let k 1
          while [ k > 0 and k < 7 ]
          [
            let l 1
            while [ l > 0 and l < 7 ]
            [
              set hc4 ( list i j k l )
              if i != j and k != j and k != i and l != k and l != i and l != j
              [
                set hc4 sort hc4
                set ValidHabs lput hc4 ValidHabs
                set ValidHabs remove-duplicates ValidHabs
              ]
              set l l + 1
            ]
            set k k + 1
          ]
          set j j + 1
        ]
        set i i + 1
      ]
    ]
    let hc5 [ ]
    if combination = 5
    [
      let i 1
      while [ i > 0 and i < 7 ]
      [
        let j 1
        while [ j > 0 and j < 7 ]
        [
          let k 1
          while [ k > 0 and k < 7 ]
          [
            let l 1
            while [ l > 0 and l < 7 ]
            [
              let m 1
              while [ m > 0 and m < 7 ]
              [
                set hc5 ( list i j k l m )
                if i != j and k != j and k != i and l != k and l != i and l != j and m != k and m != i and m != j and m != l
                [
                  set hc5 sort hc5
                  set ValidHabs lput hc5 ValidHabs
                  set ValidHabs remove-duplicates ValidHabs
                ]
                set m m + 1
              ]
              set l l + 1
            ]
            set k k + 1
          ]
          set j j + 1
        ]
        set i i + 1
      ]
    ]
    let hc6 [ ]
    if combination = 6
    [
      let i 1
      while [ i > 0 and i < 7 ]
      [
        let j 1
        while [ j > 0 and j < 7 ]
        [
          let k 1
          while [ k > 0 and k < 7 ]
          [
            let l 1
            while [ l > 0 and l < 7 ]
            [
              let m 1
              while [ m > 0 and m < 7 ]
              [
                let n 1
                while [ n > 0 and n < 7 ]
                  [
                    set hc6 ( list i j k l m n )
                    if i != j and k != j and k != i and l != k and l != i and l != j and m != k and m != i and m != j and m != l and n != i and n != j and n != k and n != l and n != m
                    [
                      set hc6 sort hc6
                      set ValidHabs lput hc6 ValidHabs
                      set ValidHabs remove-duplicates ValidHabs
                    ]
                    set n n + 1
                ]
                set m m + 1
              ]
              set l l + 1
            ]
            set k k + 1
          ]
          set j j + 1
        ]
        set i i + 1
      ]
    ]
    set combination combination + 1
  ]
  ;print ( word "habitatcover non-repeated combinations: " ValidHabs )
  ;set ValidHabs [ [1] [2] [3] [4] [5] [6] [1 2] [1 3] [1 4] [1 5] [1 6] [2 3] [2 4] [2 5] [2 6] [3 4] [3 5] [3 6] [4 5] [4 6] [5 6] [1 2 3] [1 2 4] [1 2 5] [1 2 6] [1 3 4] [1 3 5] [1 3 6] [1 4 5] [1 4 6] [1 5 6] [2 3 4] [2 3 5] [2 3 6] [2 4 5] [2 4 6] [2 5 6] [3 4 5] [3 4 6] [3 5 6] [4 5 6] [1 2 3 4] [1 2 3 5] [1 2 3 6] [1 2 4 5] [1 2 4 6] [1 2 5 6] [1 3 4 5] [1 3 4 6] [1 3 5 6] [1 4 5 6] [2 3 4 5] [2 3 4 6] [2 3 5 6] [2 4 5 6] [3 4 5 6] [1 2 3 4 5] [1 2 3 4 6] [1 2 3 5 6] [1 2 4 5 6] [1 3 4 5 6] [2 3 4 5 6] [1 2 3 4 5 6] ]
end
to sub-setup
  clear-method ;; CALL A PROCEDURE
  random-seed RandomSeeds
  let start timer ;; start time
  ifelse ( Display? = true ) [ display ] [ no-display ] ;; shut on/off the display to take much  patch-faster to run the code using switch in GUI
  ;; use input "EdgeSize" in inter patch-face of NetLogo
  resize-world EdgeSize * 0 ( EdgeSize * 1 )  ( EdgeSize * -1 ) EdgeSize * 0 ;; defines the edge size of the world and location of origin: corner top left
  setup-patches ;; CALL A PROCEDURE
  reset-ticks
  if vid:recorder-status = "recording" [ vid:record-view ]
  let finish timer ;; finish time
  ; print ( word "that setup took " ( finish - start ) " seconds" )
end
to clear-method
  set AccumulatedEnergy 0
  set Landcover 0
  set Constance 1
  set ListProfiles [ ]
  set StabilityList [ ]
  Set ListNInitial [ ]
  set ListDeath [ ]
  set ListBirth [ ]
  set ListR [ ]
  set Output-Data-1List [ ]
  clear-ticks
  clear-turtles
  clear-drawing
  clear-all-plots
  clear-output
end
;; ===========================================================================
;;;; MAP SETUP ;;;;
to setup-layers ;; load in the datas for landscape
                ;; note that setting the coordinate system here is optional, as long as all of your datasets use the same coordinate system
  let number NumLandscapes ;; number of landcovers to be loaded in sequence. In the current configuration 27 landcovers
  let number2 BeeSize
  set AccumulatedEnergy gis:load-dataset ( word "./LAYERS/LANDSCAPES_QUALITY/SumAccumulateResource_Landscape" number "_sum-of-2NDVIs-and-10seeds_" number2 "mm_10km" ".asc" ) ;; this loads a map presenting accumulated resources from BEEFOR-ABM (landscape quality maps)
  set Landcover gis:load-dataset ( word "./LAYERS/LANDCOVERS/L" number ".asc" ) ;; this loads a map presenting a landcover
  ;; set the world envelope to the union of all of our dataset's envelopes
  gis:set-world-envelope gis:envelope-of AccumulatedEnergy
  gis:apply-raster AccumulatedEnergy accumulated-energy-value
  gis:apply-raster Landcover habitatcover
  ;color-accumulated-energy
  ;color-Landcover
end
;to color-accumulated-energy ;; color the accumulated energy
;  set ValueDiff MaxAccumulatedEnergyValue - MinAccumulatedEnergyValue
;  set EqualParts ValueDiff / 3
;  set EqualParts precision EqualParts 0
;  set SumEqualParts EqualParts + EqualParts
;  ask patches
;  [
;    (
;      ifelse
;      accumulated-energy-value <= EqualParts [ set pcolor gray ] ;; low values of accumulated resource
;      accumulated-energy-value > EqualParts and accumulated-energy-value  <= SumEqualParts [ set pcolor green ];; intermediary values of accumulated resource
;      accumulated-energy-value > SumEqualParts [ set pcolor green - 4 ] ;; high values of accumulated resource
;    )
;  ]
;end
;
;to color-Landcover ;; color the landcover
;  ask patches
;  [
;    (
;      ifelse
;      habitatcover = 1 [ set pcolor orange + 2.9 ] ;; crop rotation: functional patches
;      habitatcover = 2 [ set pcolor orange - 2 ] ;; perennial crop: functional patches
;      habitatcover = 3 [ set pcolor green + 1 ] ;; native grassland: functional patches
;      habitatcover = 4 [ set pcolor green - 1 ] ;; native shrubland: functional patches
;      habitatcover = 5 [ set pcolor green - 2.5 ] ;; native forest: functional patches
;      habitatcover = 6 [ set pcolor brown ] ;; environments that were regenerating, bare soil and roadsides: functional patches
;      habitatcover = 7 [ set pcolor blue ] ;; without floral cover (water / shadow): non-functional patches
;    )
;  ]
;end
;; ===========================================================================
;;;; PATCHES SETUP ;;;;
to setup-patches
  ;; use input "ViewPatchSize" in GUI
  set-patch-size ViewPatchSize ;; view patch size
  set HotPatchSet patches with [ ( habitatcover != 7 ) ]
  set ColonyMetabolism1 ( 0.4 * MaxAccumulatedEnergyValue ) ;; high metabolism (40% of the highest accumulated resource value for all landscapes for that species)
  set ColonyMetabolism1 precision ColonyMetabolism1 0
  set ColonyMetabolism2 ( 0.2 * MaxAccumulatedEnergyValue ) ;; intermediary metabolism (20% of the highest accumulated resource value for all landscapes for that species)
  set ColonyMetabolism2 precision ColonyMetabolism2 0
  set ColonyMetabolism3 ( 0.1 * MaxAccumulatedEnergyValue ) ;; low metabolism (10% of the highest accumulated resource value for all landscapes for that species)
  set ColonyMetabolism3 precision ColonyMetabolism3 0
  set EnergyReproduction1 ( 2 * ColonyMetabolism1 ) ;; high reproduction (ColonyMetabolism1 double)
  set EnergyReproduction1 precision EnergyReproduction1 0
  set EnergyReproduction2 ( 2 * ColonyMetabolism2 ) ;; intermediary reproduction (ColonyMetabolism2 double)
  set EnergyReproduction2 precision EnergyReproduction2 0
  set EnergyReproduction3 ( 2 * ColonyMetabolism3 ) ;; low reproduction (ColonyMetabolism3 double)
  set EnergyReproduction3 precision EnergyReproduction3 0
  let list1 ( list ColonyMetabolism1 ColonyMetabolism2 ColonyMetabolism3 )
  let list2 ( list EnergyReproduction1 EnergyReproduction2 EnergyReproduction3 )
  let n0 count colonies
  set CurrentHotPatchSet HotPatchSet with [ habitatcover = one-of item ValidHabsItem ValidHabs ]
  ;set CurrentHotPatchSet HotPatchSet with [ member? ( habitatcover ) ( item ValidHabsItem ValidHabs ) ]
  let s ( length list1 ) * ( length list2 ) * num-BeeColony-per-Profile
  while [ n0 < s ]
  [
    (
      foreach list1
      [
        this-metabolism ->
        foreach list2
        [
          this-reproduction ->
          let c count CurrentHotPatchSet
          if c = 0 [ stop ]
          ask one-of CurrentHotPatchSet
          [
            sprout-colonies 1
            [
              set colony-profiles-habitat item ValidHabsItem ValidHabs
              set colony-metabolism this-metabolism
              set energy-reproduction this-reproduction
              setup-colonies
              ListProfilesProc ;; CALL A PROCEDURE
            ]
            set CurrentHotPatchSet CurrentHotPatchSet with [ not any? colonies in-radius 3 ]
          ]
        ]
      ]
    )
    set n0 count colonies
  ]
  ; print "\nmade it\n"
end
;; ===========================================================================
;;;; BEE COLONIES SETUP ;;;;
to setup-colonies
  set done-output2 false
  set done-output4 false
  set energy-colony 0
  ; set size 2
  set heading 0
  set shape "mybeecolony"
  set colony-profiles-habitat-code reduce_list colony-profiles-habitat
  (
    ifelse
    colony-metabolism = ColonyMetabolism1 [ set colony-profiles-metabolism-code "_M1" ]
    colony-metabolism = ColonyMetabolism2 [ set colony-profiles-metabolism-code "_M2" ]
    colony-metabolism = ColonyMetabolism3 [ set colony-profiles-metabolism-code "_M3" ]
  )
  (
    ifelse
    energy-reproduction = EnergyReproduction1 [ set colony-profiles-reproduction-code "_R1" ]
    energy-reproduction = EnergyReproduction2 [ set colony-profiles-reproduction-code "_R2" ]
    energy-reproduction = EnergyReproduction3 [ set colony-profiles-reproduction-code "_R3" ]
  )
  set colony-profiles-code ( word colony-profiles-habitat-code colony-profiles-reproduction-code colony-profiles-metabolism-code )
  set colony-met-repro-code-color ( word colony-profiles-reproduction-code colony-profiles-metabolism-code )
  (
    ifelse
    colony-met-repro-code-color = "_R1_M1"
    [
      set color 45
    ]
    colony-met-repro-code-color = "_R2_M1"
    [
      set color 42
    ]
    colony-met-repro-code-color = "_R3_M1"
    [
      set color 43
    ]
    colony-met-repro-code-color = "_R1_M2"
    [
      set color 44
    ]
    colony-met-repro-code-color = "_R2_M2"
    [
      set color 41
    ]
    colony-met-repro-code-color = "_R3_M2"
    [
      set color 46
    ]
    colony-met-repro-code-color = "_R1_M3"
    [
      set color 47
    ]
    colony-met-repro-code-color = "_R2_M3"
    [
      set color 48
    ]
    colony-met-repro-code-color = "_R3_M3"
    [
      set color 49
    ]
  )
  set c-p-h-item-ValidHabs colony-profiles-habitat
  (
    ifelse
    length c-p-h-item-ValidHabs = 1
    [
      let a 1
      while [ a < 7 ]
      [
        if member? a c-p-h-item-ValidHabs
        [
          set my-patches patches with [ habitatcover = a ]
        ]
        set a a + 1
      ]
    ]
    length c-p-h-item-ValidHabs = 2
    [
      let a 1
      while [ a < 7 ]
      [
        let b 1
        while [ b < 7 ]
        [
          if a = item 0 c-p-h-item-ValidHabs and b = item 1 c-p-h-item-ValidHabs
          [
            set my-patches patches with [ habitatcover = a or habitatcover = b ]
          ]
          set b b + 1
        ]
        set a a + 1
      ]
    ]
    length c-p-h-item-ValidHabs = 3
    [
      let a 1
      while [ a < 7 ]
      [
        let b 1
        while [ b < 7 ]
        [
          let c 1
          while [ c < 7 ]
          [
            if a = item 0 c-p-h-item-ValidHabs and b = item 1 c-p-h-item-ValidHabs and c = item 2 c-p-h-item-ValidHabs
            [
              set my-patches patches with [ habitatcover = a or habitatcover = b or habitatcover = c ]
            ]
            set c c + 1
          ]
          set b b + 1
        ]
        set a a + 1
      ]
    ]
    length c-p-h-item-ValidHabs = 4
    [
      let a 1
      while [ a < 7 ]
      [
        let b 1
        while [ b < 7 ]
        [
          let c 1
          while [ c < 7 ]
          [
            let d 1
            while [ d < 7 ]
            [
              if a = item 0 c-p-h-item-ValidHabs and b = item 1 c-p-h-item-ValidHabs and c = item 2 c-p-h-item-ValidHabs and d = item 3 c-p-h-item-ValidHabs
              [
                set my-patches patches with [ habitatcover = a or habitatcover = b or habitatcover = c or habitatcover = d ]
              ]
              set d d + 1
            ]
            set c c + 1
          ]
          set b b + 1
        ]
        set a a + 1
      ]
    ]
    length c-p-h-item-ValidHabs = 5
    [
      let a 1
      while [ a < 7 ]
      [
        let b 1
        while [ b < 7 ]
        [
          let c 1
          while [ c < 7 ]
          [
            let d 1
            while [ d < 7 ]
            [
              let f 1
              while [ f < 7 ]
              [
                if a = item 0 c-p-h-item-ValidHabs and b = item 1 c-p-h-item-ValidHabs and c = item 2 c-p-h-item-ValidHabs and d = item 3 c-p-h-item-ValidHabs and f = item 4 c-p-h-item-ValidHabs
                [
                  set my-patches patches with [ habitatcover = a or habitatcover = b or habitatcover = c or habitatcover = d or habitatcover = f ]
                ]
                set f f + 1
              ]
              set d d + 1
            ]
            set c c + 1
          ]
          set b b + 1
        ]
        set a a + 1
      ]
    ]
    length c-p-h-item-ValidHabs = 6
    [
      let a 1
      while [ a < 7 ]
      [
        let b 1
        while [ b < 7 ]
        [
          let c 1
          while [ c < 7 ]
          [
            let d 1
            while [ d < 7 ]
            [
              let f 1
              while [ f < 7 ]
              [
                let g 1
                while [ g < 7 ]
                [
                  if a = item 0 c-p-h-item-ValidHabs and b = item 1 c-p-h-item-ValidHabs and c = item 2 c-p-h-item-ValidHabs and d = item 3 c-p-h-item-ValidHabs and f = item 4 c-p-h-item-ValidHabs and g = item 5 c-p-h-item-ValidHabs
                  [
                    set my-patches patches with [ habitatcover = a or habitatcover = b or habitatcover = c or habitatcover = d or habitatcover = f  or habitatcover = g ]
                  ]
                  set g g + 1
                ]
                set f f + 1
              ]
              set d d + 1
            ]
            set c c + 1
          ]
          set b b + 1
        ]
        set a a + 1
      ]
    ]
  )
end
to-report reduce_list [ a_list ]
  report read-from-string word reduce word a_list ""
end
;; ===========================================================================
;;;; BEE COLONIES ACTIONS ;;;;
to go
  if NumLandscapes = num-LandscapeFiles + 1  [ stop ]
  let start timer ;; start time
  ifelse ( Display? = true ) [ display ] [ no-display ]
  ListProfilesProc ;; CALL A PROCEDURE
  ListDeathProc ;; CALL A PROCEDURE
  ListNInitialProc ;; CALL A PROCEDURE
  CallOutupt1Proc ;; CALL A PROCEDURE
  EnvironmentalVariationProc ;; CALL A PROCEDURE
  MetabolicColonyProc ;; CALL A PROCEDURE
  CallOutupts2-4Proc ;; CALL A PROCEDURE
  ProbDieColonyProc ;; CALL A PROCEDURE
  ListNFinalProc ;; CALL A PROCEDURE
  CallOutupt1-Proc ;; CALL A PROCEDURE
  ListTicksProc ;; CALL A PROCEDURE
  FillingListProc ;; CALL A PROCEDURE
  Output-Data-1 ;; CALL A PROCEDURE
  StabilityCheckerProc ;; CALL A PROCEDURE
  ListProfilesProc ;; CALL A PROCEDURE
  tick
  let n count colonies
  ifelse ConstanceCounter = 0
  [
    set ConstanceCounter ConstanceCounter + 1
  ]
  [
    set ConstanceCounter 0
  ]
  if ConstanceCounter = DurationConstance or n = 0 or ticks = Duration
  [
    set ValidHabsItem ValidHabsItem + 1
    if ValidHabsItem = length ValidHabs
    [
      set ValidHabsItem 0
      set RandomSeeds RandomSeeds + 1
      set Output1 false
      set Output2 false
      set Output3 false
      set Output4 false
      if RandomSeeds = Repetitions + 1
      [
        set RandomSeeds 1
        set NumLandscapes NumLandscapes + 1
        if NumLandscapes = num-LandscapeFiles + 1 [ stop ]
        setup-layers ;; CALL A PROCEDURE
      ]
    ]
    sub-setup
  ]
  let finish timer ;; finish time
  ; print ( word "that tick took " ( finish - start ) " seconds" )
  if vid:recorder-status = "recording" [ vid:record-view ]
end
;; ===========================================================================
;; LIST IDENTIFY COLONY PROFILES PROCEDURE
to ListProfilesProc ;; RUN A PROCEDURE
  set ListProfiles [ ]
  ask colonies
  [
    set ListProfiles lput colony-profiles-code ListProfiles
  ]
  set ListProfiles sort remove-duplicates ListProfiles
  set NumberProfiles length ListProfiles
end
;; ===========================================================================
;; LIST DEATH PROCEDURE
to ListDeathProc ;; RUN A PROCEDURE
  let l length ListProfiles
  set ListDeath n-values l [ 0 ]
end
;; ===========================================================================
;; LIST INITIAL PROCEDURE
to ListNInitialProc ;; RUN A PROCEDURE
  set ListNInitial [ ]
  foreach ListProfiles [ lp ->
    let c count colonies with [ colony-profiles-code = lp ]
    set ListNInitial lput c ListNInitial
  ]
end
;; ===========================================================================
;; CALL OUTPUT 1 INITIAL PROCEDURE
to CallOutupt1Proc ;; RUN A PROCEDURE
foreach ListProfiles [ lp ->
    set NInitial count colonies with [ colony-profiles-code = lp ]
  ]
end
;; ===========================================================================
;; ENVIRONMENTAL VARIATION PROCEDURE
to EnvironmentalVariationProc ;; RUN A PROCEDURE
  ifelse ticks > 0
  [
    set EnvironmentalVariation random-float 1.01
    ;set EnvironmentalVariation random-normal 1 5 ;; if using the normal distribution, change the values of mean and standard-deviation
  ]
  [ ]
end
;; ===========================================================================
;; METABOLIC COLONY PROCEDURE
to MetabolicColonyProc ;; RUN A PROCEDURE
  set MinimumEnergy1 ( -0.75 * ColonyMetabolism1 )
  set MinimumEnergy1 precision MinimumEnergy1 0
  set MinimumEnergy2 ( -0.75 * ColonyMetabolism2 )
  set MinimumEnergy2 precision MinimumEnergy2 0
  set MinimumEnergy3 ( -0.75 * ColonyMetabolism3 )
  set MinimumEnergy3 precision MinimumEnergy3 0
  ifelse ticks > 0
  [
    ask colonies
    [
      CallOutupts2-4-Proc ;; CALL A PROCEDURE
      let z [ accumulated-energy-value ] of patch-here
      (
        ifelse
        colony-metabolism = ColonyMetabolism1
        [
          set energy-colony ( energy-colony + ( z * EnvironmentalVariation ) - ColonyMetabolism1 )
          set energy-colony precision energy-colony 0
          if energy-colony <= MinimumEnergy1 [ DieProc ]
          (
            ifelse
            energy-reproduction = EnergyReproduction1
            [
              if energy-colony >= EnergyReproduction1 [ DispersionColonyProc ]
            ]
            energy-reproduction = EnergyReproduction2
            [
              if energy-colony >= EnergyReproduction2 [ DispersionColonyProc ]
            ]
            energy-reproduction = EnergyReproduction3
            [
              if energy-colony >= EnergyReproduction3 [ DispersionColonyProc ]
            ]
          )
        ]
        colony-metabolism = ColonyMetabolism2
        [
          set energy-colony ( energy-colony + ( z * EnvironmentalVariation ) - ColonyMetabolism2 )
          set energy-colony precision energy-colony 0
          if energy-colony <= MinimumEnergy2 [ DieProc ]
          (
            ifelse
            energy-reproduction = EnergyReproduction1
            [
              if energy-colony >= EnergyReproduction1 [ DispersionColonyProc ]
            ]
            energy-reproduction = EnergyReproduction2
            [
              if energy-colony >= EnergyReproduction2 [ DispersionColonyProc ]
            ]
            energy-reproduction = EnergyReproduction3
            [
              if energy-colony >= EnergyReproduction3 [ DispersionColonyProc ]
            ]
          )
        ]
        colony-metabolism = ColonyMetabolism3
        [
          set energy-colony ( energy-colony + ( z * EnvironmentalVariation ) - ColonyMetabolism3 )
          set energy-colony precision energy-colony 0
          if energy-colony <= MinimumEnergy3 [ DieProc ]
          (
            ifelse
            energy-reproduction = EnergyReproduction1
            [
              if energy-colony >= EnergyReproduction1 [ DispersionColonyProc ]
            ]
            energy-reproduction = EnergyReproduction2
            [
              if energy-colony >= EnergyReproduction2 [ DispersionColonyProc ]
            ]
            energy-reproduction = EnergyReproduction3
            [
              if energy-colony >= EnergyReproduction3 [ DispersionColonyProc ]
            ]
          )
        ]
      )
    ]
  ]
  [
    ask colonies
    [
      CallOutupts2-4-Proc ;; CALL A PROCEDURE
      let z [ accumulated-energy-value ] of patch-here
      (
        ifelse
        colony-metabolism = ColonyMetabolism1
        [
          set energy-colony ( energy-colony + ( z ) - ColonyMetabolism1 )
          set energy-colony precision energy-colony 0
          if energy-colony <= MinimumEnergy1 [ DieProc ]
          (
            ifelse
            energy-reproduction = EnergyReproduction1
            [
              if energy-colony >= EnergyReproduction1 [ DispersionColonyProc ]
            ]
            energy-reproduction = EnergyReproduction2
            [
              if energy-colony >= EnergyReproduction2 [ DispersionColonyProc ]
            ]
            energy-reproduction = EnergyReproduction3
            [
              if energy-colony >= EnergyReproduction3 [ DispersionColonyProc ]
            ]
          )
        ]
        colony-metabolism = ColonyMetabolism2
        [
          set energy-colony ( energy-colony + ( z ) - ColonyMetabolism2 )
          set energy-colony precision energy-colony 0
          if energy-colony <= MinimumEnergy2 [ DieProc ]
          (
            ifelse
            energy-reproduction = EnergyReproduction1
            [
              if energy-colony >= EnergyReproduction1 [ DispersionColonyProc ]
            ]
            energy-reproduction = EnergyReproduction2
            [
              if energy-colony >= EnergyReproduction2 [ DispersionColonyProc ]
            ]
            energy-reproduction = EnergyReproduction3
            [
              if energy-colony >= EnergyReproduction3 [ DispersionColonyProc ]
            ]
          )
        ]
        colony-metabolism = ColonyMetabolism3
        [
          set energy-colony ( energy-colony + ( z ) - ColonyMetabolism3 )
          set energy-colony precision energy-colony 0
          if energy-colony <= MinimumEnergy3 [ DieProc ]
          (
            ifelse
            energy-reproduction = EnergyReproduction1
            [
              if energy-colony >= EnergyReproduction1 [ DispersionColonyProc ]
            ]
            energy-reproduction = EnergyReproduction2
            [
              if energy-colony >= EnergyReproduction2 [ DispersionColonyProc ]
            ]
            energy-reproduction = EnergyReproduction3
            [
              if energy-colony >= EnergyReproduction3 [ DispersionColonyProc ]
            ]
          )
        ]
      )
    ]
  ]
end
;; ===========================================================================
;; CALL OUTPUTS 2 and 4 INITIAL PROCEDURE
to CallOutupts2-4-Proc ;; RUN A PROCEDURE
    set done-output4 false
    Output-Data-4 ;; CALL A PROCEDURE
    if done-output2 = false
    [
      Output-Data-2 ;; CALL A PROCEDURE
      set done-output2 true
    ]
    set done-output4 true
end
;; ===========================================================================
;; DISPERSION OF COLONY PROCEDURE
to DispersionColonyProc ; RUN A PROCEDURE
  let p 0
  while [ p < num-ColonyDivision ]
  [
    let available-patch my-patches with [ distance myself > 3 and distance myself < MaxMotherColonyDistance and count colonies-here = 0 and not any? other colonies in-radius 3 ]
    set PatchAvailable count available-patch
    if PatchAvailable = 0 [ stop ]
    let choose-patch one-of available-patch
    let coordx [ pxcor ] of choose-patch
    let coordy [ pycor ] of choose-patch
    hatch 1
    [
      setxy coordx coordy
      (
        ifelse
        colony-met-repro-code-color = "_R1_M1"
        [
          set color 15
        ]
        colony-met-repro-code-color = "_R2_M1"
        [
          set color 12
        ]
        colony-met-repro-code-color = "_R3_M1"
        [
          set color 13
        ]
        colony-met-repro-code-color = "_R1_M2"
        [
          set color 14
        ]
        colony-met-repro-code-color = "_R2_M2"
        [
          set color 11
        ]
        colony-met-repro-code-color = "_R3_M2"
        [
          set color 16
        ]
        colony-met-repro-code-color = "_R1_M3"
        [
          set color 17
        ]
        colony-met-repro-code-color = "_R2_M3"
        [
          set color 18
        ]
        colony-met-repro-code-color = "_R3_M3"
        [
          set color 19
        ]
      )
      set done-output2 false
      set done-output4 false
      set energy-colony 0
      set p p + 1
    ]
    set energy-colony energy-colony - energy-reproduction
    set energy-colony precision energy-colony 0
  ]
end
;; ===========================================================================
;; COLONY DEATH PROCEDURE
to DieProc
  let pos-lp position colony-profiles-code ListProfiles
  let value-death item pos-lp ListDeath
  set ListDeath replace-item pos-lp ListDeath ( value-death + 1 )
  Output-Data-3 ;; CALL A PROCEDURE
  die
end
;; ===========================================================================
;; CALL OUTPUTS 2 and 4 FINAL PROCEDURE
to CallOutupts2-4Proc ;; RUN A PROCEDURE
  ask colonies
  [
    if done-output4 = false
    [
      Output-Data-4 ;; CALL A PROCEDURE
    ]
    if done-output2 = false
    [
      Output-Data-2 ;; CALL A PROCEDURE
      set done-output2 true
    ]
  ]
end
;; ===========================================================================
;; RANDOM COLONY DEATH PROCEDURE
to ProbDieColonyProc ;; RUN A PROCEDURE
  ask colonies
  [
    (
      ifelse
      energy-colony <= ( energy-reproduction * 0.33 )
      [
        let prob-die random-float 1.01
        if prob-die <= 0.67 [ DieProc ]
      ]
      energy-colony > ( energy-reproduction * 0.33 ) and energy-colony <= ( energy-reproduction * 0.66 )
      [
        let prob-die random-float 1.01
        if prob-die <= 0.34 [ DieProc ]
      ]
      energy-colony > ( energy-reproduction * 0.66 )
      [
        let prob-die random-float 1.01
        if prob-die <= 0.1 [ DieProc ]
      ]
    )
  ]
end
;; ===========================================================================
;; LIST NFINAL PROCEDURE
to ListNFinalProc ;; RUN A PROCEDURE
  set ListNFinal [ ]
  foreach ListProfiles [ lp ->
    let c count colonies with [ colony-profiles-code = lp ]
    set ListNFinal lput c ListNFinal
  ]
end
;; ===========================================================================
;; CALL OUTPUT 1 FINAL PROCEDURE
to CallOutupt1-Proc ;; RUN A PROCEDURE
  set ListR [ ]
  set ListBirth [ ]
  (
    foreach ListDeath ListNFinal ListNInitial
    [
      [ a b c ] -> let d ( a + b - c )
      set ListBirth lput d ListBirth
    ]
  )
  (
    foreach ListBirth ListDeath ListNInitial
    [
      [ a b c ] -> let d ( a - b ) / c
      set d precision d 2
      set ListR lput d ListR
    ]
  )
end
;; ===========================================================================
;; LIST TICKS PROCEDURE
to ListTicksProc ;; RUN A PROCEDURE
  let l length ListProfiles
  set ListTicks n-values l [ ticks ]
end
;; ===========================================================================
;; FILLING LIST PROCEDURE
to FillingListProc ;; RUN A PROCEDURE
  set Output-Data-1List [ ]
  (
    foreach ListProfiles ListNInitial ListNFinal ListBirth ListDeath ListR ListTicks
    [
      [ a b c d f g h ] ->
      let to-append ( list a b c d f g h )
      set Output-Data-1List lput to-append Output-Data-1List
    ]
  )
end
;; ===========================================================================
;; STABILITY CHECKER PROCEDURE
to StabilityCheckerProc ;; RUN A PROCEDURE
  set StabilityList lput NFinal StabilityList
  let i 2
  if length StabilityList = i
  [
    let t1 last StabilityList
    let start ( length StabilityList - i )
    let t0 item start StabilityList
    set Constance abs ( t1 - t0 )
  ]
  set StabilityList get-last ( i - 1) StabilityList
end
to-report get-last [ num lst ]
  let b length lst
  let a b - num
  report sublist lst ( ifelse-value ( a < 0 ) [ 0 ] [ a ] ) b
end
;; ===========================================================================
;;;;;;;;;;;;;;;;  WRITING FILES ;;;;;;;;;;;;;;;;;;;;;;;;
;; RUN A PROCEDURE
to Output-Data-1 ;; PopulationDynamicsColonyProfiles
  ifelse Output-Data-1? = true
  [
    let numLand word "_Landscape" NumLandscapes
    let numSeed word "_seed" RandomSeeds
    let numBeeSize ( word "_" BeeSize "mm" )
    let y EdgeSize
    set y ( ( ( y + 1 ) * 10 ) ) / 1000
    let numEdgeSize ( word "_" y "km" )
   ; file-close-all
    file-open ( word NameOutfile-Ouput-Data-1 numLand numSeed numBeeSize numEdgeSize ".csv" )
    if Output1 = false and ValidHabsItem = 0
    [
      ; file-print ""  ;; blank line
      file-close
      if file-exists? ( word NameOutfile-Ouput-Data-1 numLand numSeed numBeeSize numEdgeSize ".csv" )
      [ file-delete ( word NameOutfile-Ouput-Data-1 numLand numSeed numBeeSize numEdgeSize ".csv" ) ]
      file-open ( word NameOutfile-Ouput-Data-1 numLand numSeed numBeeSize numEdgeSize ".csv" )
      file-print ( word "code_colony_profile,n_initial,n_final,birth,death,r,tick" )
      set Output1 true
    ]
    ; export the list to csv
    let Output-Data-1-string csv:to-string Output-Data-1List
    file-print Output-Data-1-string
    file-close
  ]
  [ ]
end
to Output-Data-2 ;; BirthDistribuitionColonyProfile
  ifelse Output-Data-2? = true
  [
    let numLand word "_Landscape" NumLandscapes
    let numSeed word "_seed" RandomSeeds
    let numBeeSize ( word "_" BeeSize "mm" )
    let y EdgeSize
    set y ( ( ( y + 1 ) * 10 ) ) / 1000
    let numEdgeSize ( word "_" y "km" )
    file-open ( word NameOutfile-Ouput-Data-2 numLand numSeed numBeeSize numEdgeSize ".csv" )
    if Output2 = false and ValidHabsItem = 0
    [
      ; file-print ""  ;; blank line
      file-close
      if file-exists? ( word NameOutfile-Ouput-Data-2 numLand numSeed numBeeSize numEdgeSize ".csv" )
      [ file-delete ( word NameOutfile-Ouput-Data-2 numLand numSeed numBeeSize numEdgeSize ".csv" ) ]
      file-open ( word NameOutfile-Ouput-Data-2 numLand numSeed numBeeSize numEdgeSize ".csv" )
      file-print ( word "code_colony_profile,agent_colony,my-xcor,my-ycor,tick" )
      set Output2 true
    ]
    file-print ( word colony-profiles-code "," who "," xcor "," ycor "," ticks )
    file-close
  ]
  [ ]
end
to Output-Data-3 ;; DeathDistribuitionColonyProfile
  ifelse Output-Data-3? = true
  [
    let numLand word "_Landscape" NumLandscapes
    let numSeed word "_seed" RandomSeeds
    let numBeeSize ( word "_" BeeSize "mm" )
    let y EdgeSize
    set y ( ( ( y + 1 ) * 10 ) ) / 1000
    let numEdgeSize ( word "_" y "km" )
    file-open ( word NameOutfile-Ouput-Data-3 numLand numSeed numBeeSize numEdgeSize ".csv" )
    if Output3 = false and ValidHabsItem = 0
    [
      ; file-print ""  ;; blank line
      file-close
      if file-exists? ( word NameOutfile-Ouput-Data-3 numLand numSeed numBeeSize numEdgeSize ".csv" )
      [ file-delete ( word NameOutfile-Ouput-Data-3 numLand numSeed numBeeSize numEdgeSize ".csv" ) ]
      file-open ( word NameOutfile-Ouput-Data-3 numLand numSeed numBeeSize numEdgeSize ".csv" )
      file-print ( word "code_colony_profile,agent_colony,my-xcor,my-ycor,tick" )
      set Output3 true
    ]
    file-print ( word colony-profiles-code "," who "," xcor "," ycor "," ticks )
    file-close
  ]
  [ ]
end
to Output-Data-4 ;; SpatialDistributionColonyProfiles
  ifelse Output-Data-4? = true
  [
    let numLand word "_Landscape" NumLandscapes
    let numSeed word "_seed" RandomSeeds
    let numBeeSize ( word "_" BeeSize "mm" )
    let y EdgeSize
    set y ( ( ( y + 1 ) * 10 ) ) / 1000
    let numEdgeSize ( word "_" y "km" )
    file-open ( word NameOutfile-Ouput-Data-4 numLand numSeed numBeeSize numEdgeSize ".csv" )
    if Output4 = false and ValidHabsItem = 0
    [
      ; file-print ""  ;; blank line
      file-close
      if file-exists? ( word NameOutfile-Ouput-Data-4 numLand numSeed numBeeSize numEdgeSize ".csv" )
      [ file-delete ( word NameOutfile-Ouput-Data-4 numLand numSeed numBeeSize numEdgeSize ".csv" ) ]
      file-open ( word NameOutfile-Ouput-Data-4 numLand numSeed numBeeSize numEdgeSize ".csv" )
      file-print ( word "code_colony_profile,agent_colony,my-xcor,my-ycor,tick" )
      set Output4 true
    ]
    file-print ( word colony-profiles-code "," who "," xcor "," ycor "," ticks )
    file-close
  ]
  [ ]
end
to snapshot
  ;; export-interface user-new-file
  let numLand word "_Landscape" NumLandscapes
  let numSeed word "_seed" RandomSeeds
  let numBeeSize ( word "_" BeeSize "mm" )
  let y EdgeSize
  set y ( ( ( y + 1 ) * 10 ) ) / 1000
  let numEdgeSize ( word "_" y "km" )
  carefully
  [ file-delete ( word "World_BEECOL" numLand numSeed numBeeSize numEdgeSize ".png" ) ]
  [ ]
  export-view ( word "World_BEECOL" numLand numSeed numBeeSize numEdgeSize ".png" )
end
;; ===========================================================================
;;;;; RECORD MOVIE FROM THE WORLD ;;;;
;; ATTENTION: This model's recording is frame rate sensitive, so consider recording each existing frame twice or consider using a post-processing tool (such as gstreamer or ffmpeg) to adjust the video playback speed
;; reference: http://ccl.northwestern.edu/netlogo/6.0.4/docs/transition.html
to start-recorder
  carefully [ vid:start-recorder ] [ user-message error-message ]
end
to reset-recorder
  let message (word
    "If you reset the recorder, the current recording will be lost"
    "Are you sure you want to reset the recorder?")
  if vid:recorder-status = "inactive" or user-yes-or-no? message [
    vid:reset-recorder
  ]
end
to save-recording
  if vid:recorder-status = "inactive" [
    user-message "The recorder is inactive. There is nothing to save"
    stop
  ]
  ; prompt user for movie location
  user-message ( word
    "Choose a name for your movie file (the "
    ".mp4 extension will be automatically added)" )
  let path2 user-new-file
  if not is-string? path2 [ stop ]  ; stop if user canceled
  ; export the movie
  carefully [
    vid:save-recording path2
    user-message ( word "Exported movie to " path2 )
  ] [
    user-message error-message
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
715
43
1723
1052
-1
-1
1.0
1
10
1
1
1
0
0
0
1
0
999
-999
0
0
0
1
ticks
30.0
SWITCH
715
10
1723
43
Display?
Display?
0
1
-1000
INPUTBOX
19
116
194
176
EdgeSize
999.0
1
0
Number
INPUTBOX
193
116
369
176
ViewPatchSize
1.0
1
0
Number
MONITOR
19
175
369
220
World area in m2:
( EdgeSize + 1 ) * 10 * ( EdgeSize + 1 ) * 10 ;; 10 is the GrainSize-m in meters\n\n;;below in km2:\n;(( EdgeSize + 1 ) * 10 * ( EdgeSize + 1 ) * 10 ) / 1000000\n\n;;below world size (total of patches in the world ):\n;;( EdgeSize + 1 ) * ( EdgeSize + 1 )
17
1
11
BUTTON
400
192
548
225
Landcover
let coord-X min-pxcor\nlet coord-Y max-pycor\nwhile [ coord-Y >= min-pycor ] [\n  while [ coord-X <= max-pxcor ] [\n    ask patch coord-X coord-Y [\n      (\n        ifelse      \n        habitatcover = 1 [ set pcolor orange + 2.9 ] ;; crop rotation: functional patches\n        habitatcover = 2 [ set pcolor orange - 2 ] ;; perennial crop: functional patches\n        habitatcover = 3 [ set pcolor green + 1 ] ;; native grassland: functional patches\n        habitatcover = 4 [ set pcolor green - 1 ] ;; native shrubland: functional patches\n        habitatcover = 5 [ set pcolor green - 2.5 ] ;; native forest: functional patches\n        habitatcover = 6 [ set pcolor brown ] ;; environments that were regenerating, bare soil and roadsides: functional patches\n        habitatcover = 7 [ set pcolor blue ] ;; without resource (water / shadow): non-functional patches\n      )       \n    ]\n    set coord-X coord-X + 1\n  ]\n  set coord-Y coord-Y - 1\n  set coord-X min-pxcor\n]  \n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
BUTTON
547
192
695
225
Landcover labels
let coord-X min-pxcor\nlet coord-Y max-pycor\nwhile [ coord-Y >= min-pycor ] [\n  while [ coord-X <= max-pxcor ] [\n    ask patch coord-X coord-Y [                 \n      ifelse plabel = \"\" [\n        set plabel habitatcover\n        set plabel-color white  \n      ] \n      [ \n        set plabel \"\"\n      ]        \n    ]\n    set coord-X coord-X + 1\n  ]\n  set coord-Y coord-Y - 1\n  set coord-X min-pxcor\n]
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
BUTTON
400
224
548
257
Crop rotation
let coord-X min-pxcor\nlet coord-Y max-pycor\nwhile [ coord-Y >= min-pycor ] [\n  while [ coord-X <= max-pxcor ] [\n    ask patch coord-X coord-Y [\n      (\n        ifelse      \n        habitatcover = 1 [ set pcolor orange + 2.9 ] ;; crop rotation: functional patches\n        habitatcover = 2 [ set pcolor white ] ;; perennial crop: functional patches\n        habitatcover = 3 [ set pcolor white ] ;; native grassland: functional patches\n        habitatcover = 4 [ set pcolor white ] ;; native shrubland: functional patches\n        habitatcover = 5 [ set pcolor white ] ;; native forest: functional patches\n        habitatcover = 6 [ set pcolor white ] ;; environments that were regenerating, bare soil and roadsides: functional patches\n        habitatcover = 7 [ set pcolor white ] ;; without resource (water / shadow): non-functional patches\n      )       \n    ]\n    set coord-X coord-X + 1\n  ]\n  set coord-Y coord-Y - 1\n  set coord-X min-pxcor\n]  \n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
BUTTON
547
224
695
257
Perennial crop
let coord-X min-pxcor\nlet coord-Y max-pycor\nwhile [ coord-Y >= min-pycor ] [\n  while [ coord-X <= max-pxcor ] [\n    ask patch coord-X coord-Y [\n      (\n        ifelse      \n        habitatcover = 1 [ set pcolor white ] ;; crop rotation: functional patches\n        habitatcover = 2 [ set pcolor orange - 2 ] ;; perennial crop: functional patches\n        habitatcover = 3 [ set pcolor white ] ;; native grassland: functional patches\n        habitatcover = 4 [ set pcolor white] ;; native shrubland: functional patches\n        habitatcover = 5 [ set pcolor white ] ;; native forest: functional patches\n        habitatcover = 6 [ set pcolor white ] ;; environments that were regenerating, bare soil and roadsides: functional patches\n        habitatcover = 7 [ set pcolor white ] ;; without resource (water / shadow): non-functional patches\n      )       \n    ]\n    set coord-X coord-X + 1\n  ]\n  set coord-Y coord-Y - 1\n  set coord-X min-pxcor\n]  \n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
BUTTON
400
256
548
289
Native grassland
let coord-X min-pxcor\nlet coord-Y max-pycor\nwhile [ coord-Y >= min-pycor ] [\n  while [ coord-X <= max-pxcor ] [\n    ask patch coord-X coord-Y [\n      (\n        ifelse      \n        habitatcover = 1 [ set pcolor white] ;; crop rotation: functional patches\n        habitatcover = 2 [ set pcolor white ] ;; Perennial crop: functional patches\n        habitatcover = 3 [ set pcolor green + 1 ] ;; native grassland: functional patches\n        habitatcover = 4 [ set pcolor white] ;; native shrubland: functional patches\n        habitatcover = 5 [ set pcolor white ] ;; native forest: functional patches\n        habitatcover = 6 [ set pcolor white ] ;; environments that were regenerating, bare soil and roadsides: functional patches\n        habitatcover = 7 [ set pcolor white ] ;; without resource (water / shadow): non-functional patches\n      )       \n    ]\n    set coord-X coord-X + 1\n  ]\n  set coord-Y coord-Y - 1\n  set coord-X min-pxcor\n]  \n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
BUTTON
547
256
695
289
Native shrubland
let coord-X min-pxcor\nlet coord-Y max-pycor\nwhile [ coord-Y >= min-pycor ] [\n  while [ coord-X <= max-pxcor ] [\n    ask patch coord-X coord-Y [\n      (\n        ifelse      \n        habitatcover = 1 [ set pcolor white ] ;; rotary agriculture: functional patches\n        habitatcover = 2 [ set pcolor white ] ;; agriculture forest: functional patches\n        habitatcover = 3 [ set pcolor white ] ;; native grassland: functional patches\n        habitatcover = 4 [ set pcolor green - 1 ] ;; native shrubland: functional patches\n        habitatcover = 5 [ set pcolor white ] ;; native forest: functional patches\n        habitatcover = 6 [ set pcolor white ] ;; environments that were regenerating, bare soil and roadsides: functional patches\n        habitatcover = 7 [ set pcolor white ] ;; without resource (water / shadow): non-functional patches   \n      )       \n    ]\n    set coord-X coord-X + 1\n  ]\n  set coord-Y coord-Y - 1\n  set coord-X min-pxcor\n]  \n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
BUTTON
400
288
548
321
Native forest
let coord-X min-pxcor\nlet coord-Y max-pycor\nwhile [ coord-Y >= min-pycor ] [\n  while [ coord-X <= max-pxcor ] [\n    ask patch coord-X coord-Y [\n      (\n        ifelse      \n        habitatcover = 1 [ set pcolor white ] ;; crop rotation: functional patches\n        habitatcover = 2 [ set pcolor white ] ;;perennial crop: functional patches\n        habitatcover = 3 [ set pcolor white ] ;; native grassland: functional patches\n        habitatcover = 4 [ set pcolor white ] ;; native shrubland: functional patches\n        habitatcover = 5 [ set pcolor green - 2.5 ] ;; native forest: functional patches \n        habitatcover = 6 [ set pcolor white ] ;; environments that were regenerating, bare soil and roadsides: functional patches\n        habitatcover = 7 [ set pcolor white ] ;; without resource (water / shadow): non-functional patches   \n      )       \n    ]\n    set coord-X coord-X + 1\n  ]\n  set coord-Y coord-Y - 1\n  set coord-X min-pxcor\n]  \n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
BUTTON
547
288
695
321
Anthropized vegetation
let coord-X min-pxcor\nlet coord-Y max-pycor\nwhile [ coord-Y >= min-pycor ] [\n  while [ coord-X <= max-pxcor ] [\n    ask patch coord-X coord-Y [\n      (\n        ifelse      \n        habitatcover = 1 [ set pcolor white ] ;; rotary agriculture: functional patches\n        habitatcover = 2 [ set pcolor white ] ;; agriculture forest: functional patches\n        habitatcover = 3 [ set pcolor white ] ;; native grassland: functional patches\n        habitatcover = 4 [ set pcolor white ] ;; native shrubland: functional patches\n        habitatcover = 5 [ set pcolor white ] ;; native forest: functional patches\n        habitatcover = 6 [ set pcolor brown ] ;; environments that were regenerating, bare soil and roadsides: functional patches\n        habitatcover = 7 [ set pcolor white ] ;; without resource (water / shadow): non-functional patches     \n      )       \n    ]\n    set coord-X coord-X + 1\n  ]\n  set coord-Y coord-Y - 1\n  set coord-X min-pxcor\n] 
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
BUTTON
400
320
548
353
Without resource
let coord-X min-pxcor\nlet coord-Y max-pycor\nwhile [ coord-Y >= min-pycor ] [\n  while [ coord-X <= max-pxcor ] [\n    ask patch coord-X coord-Y [\n      (\n        ifelse      \n        habitatcover = 1 [ set pcolor white ] ;; rotary agriculture: functional patches\n        habitatcover = 2 [ set pcolor white ] ;; agriculture forest: functional patches\n        habitatcover = 3 [ set pcolor white ] ;; native grassland: functional patches\n        habitatcover = 4 [ set pcolor white ] ;; native shrubland: functional patches\n        habitatcover = 5 [ set pcolor white ] ;; native forest: functional patches\n        habitatcover = 6 [ set pcolor white ] ;; environments that were regenerating, bare soil and roadsides: functional patches\n        habitatcover = 7 [ set pcolor blue ] ;; without resource (water / shadow): non-functional patches       \n      )       \n    ]\n    set coord-X coord-X + 1\n  ]\n  set coord-Y coord-Y - 1\n  set coord-X min-pxcor\n] 
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
BUTTON
547
320
695
353
Patch coordinate labels
let coord-X min-pxcor\nlet coord-Y max-pycor\nwhile [ coord-Y >= min-pycor ] [\n  while [ coord-X <= max-pxcor ] [\n    ask patch coord-X coord-Y [        \n      ifelse plabel = \"\" [\n        set plabel  ( word \" ( \" pxcor \",\" pycor \" )\" )\n        set plabel-color white\n      ] \n      [ \n        set plabel \"\"\n      ]       \n    ]\n    set coord-X coord-X + 1\n  ]\n  set coord-Y coord-Y - 1\n  set coord-X min-pxcor\n]\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
BUTTON
207
738
288
771
Start recorder
start-recorder
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
BUTTON
287
738
369
771
Reset recorder
reset-recorder
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
BUTTON
207
770
369
803
Save recording
save-recording
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
MONITOR
20
758
208
803
NIL
vid:recorder-status
17
1
11
TEXTBOX
21
729
215
775
Create model movie:
19
0.0
1
BUTTON
19
52
194
106
Setup
if LoadSaveDirectoryFolder = 0 and Output-Data-1? = true \n[ \n set LoadSaveDirectoryFolder 0\n  user-message \"Choose the directory to load and save the files\" ;; assumes the user will choose a directory\n  set-current-directory user-directory   \n  set LoadSaveDirectoryFolder 1 \n]\n\nif LoadSaveDirectoryFolder = 0 and Output-Data-2? = true \n[ \n set LoadSaveDirectoryFolder 0\n  user-message \"Choose the directory to load and save the files\" ;; assumes the user will choose a directory\n  set-current-directory user-directory   \n  set LoadSaveDirectoryFolder 1 \n]\n\n\nif LoadSaveDirectoryFolder = 0 and Output-Data-3? = true \n[ \n set LoadSaveDirectoryFolder 0\n  user-message \"Choose the directory to load and save the files\" ;; assumes the user will choose a directory\n  set-current-directory user-directory   \n  set LoadSaveDirectoryFolder 1 \n]\n\n\nif LoadSaveDirectoryFolder = 0 and Output-Data-4? = true \n[ \n set LoadSaveDirectoryFolder 0\n  user-message \"Choose the directory to load and save the files\" ;; assumes the user will choose a directory\n  set-current-directory user-directory   \n  set LoadSaveDirectoryFolder 1 \n]\n\nsetup ;; CALL A PROCEDURE   
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
BUTTON
193
52
369
106
Go
go ;; CALL A PROCEDURE   
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
0
TEXTBOX
21
18
299
50
Setup world and run the model:
19
0.0
1
BUTTON
400
52
548
85
Accumulated resources
set ValueDiff MaxAccumulatedEnergyValue - MinAccumulatedEnergyValue \nset EqualParts ValueDiff / 3\nset EqualParts precision EqualParts 0 \nset SumEqualParts EqualParts + EqualParts \nlet coord-X min-pxcor\nlet coord-Y max-pycor\nwhile [ coord-Y >= min-pycor ] [\n  while [ coord-X <= max-pxcor ] [\n    ask patch coord-X coord-Y [         \n      (\n        ifelse\n        accumulated-energy-value <= EqualParts [ set pcolor gray ] ;; low values of accumulated resource\n        accumulated-energy-value > EqualParts and accumulated-energy-value  <= SumEqualParts [ set pcolor green ];; intermediary values of accumulated resource\n        accumulated-energy-value > SumEqualParts [ set pcolor green - 4 ] ;; high values of accumulated resource\n      )\n    ]\n    set coord-X coord-X + 1\n  ]\n  set coord-Y coord-Y - 1\n  set coord-X min-pxcor\n]  
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
BUTTON
547
52
695
85
Accumulated resource labels
let coord-X min-pxcor\nlet coord-Y max-pycor\nwhile [ coord-Y >= min-pycor ] [\n  while [ coord-X <= max-pxcor ] [\n    ask patch coord-X coord-Y [\n      ifelse plabel = \"\" [\n        set plabel accumulated-energy-value\n        set plabel-color white  \n      ] \n      [ \n        set plabel \"\"\n      ]\n    ]    \n    set coord-X coord-X + 1\n  ]\n  set coord-Y coord-Y - 1\n  set coord-X min-pxcor\n]
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
BUTTON
400
84
695
117
High values of accumulated resource
set ValueDiff MaxAccumulatedEnergyValue - MinAccumulatedEnergyValue \nset EqualParts ValueDiff / 3\nset EqualParts precision EqualParts 0 \nset SumEqualParts EqualParts + EqualParts \nlet coord-X min-pxcor\nlet coord-Y max-pycor\nwhile [ coord-Y >= min-pycor ] [\n  while [ coord-X <= max-pxcor ] [\n    ask patch coord-X coord-Y [         \n      (\n        ifelse\n        accumulated-energy-value <= EqualParts [ set pcolor white ] ;; low values of accumulated resource\n        accumulated-energy-value > EqualParts and accumulated-energy-value  <= SumEqualParts [ set pcolor white ];; intermediary values of accumulated resource\n        accumulated-energy-value > SumEqualParts [ set pcolor green - 4 ] ;; high values of accumulated resource\n      )\n    ]\n    set coord-X coord-X + 1\n  ]\n  set coord-Y coord-Y - 1\n  set coord-X min-pxcor\n]
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
BUTTON
400
116
695
149
Intermediate values of accumulated resource
set ValueDiff MaxAccumulatedEnergyValue - MinAccumulatedEnergyValue \nset EqualParts ValueDiff / 3\nset EqualParts precision EqualParts 0 \nset SumEqualParts EqualParts + EqualParts \nlet coord-X min-pxcor\nlet coord-Y max-pycor\nwhile [ coord-Y >= min-pycor ] [\n  while [ coord-X <= max-pxcor ] [\n    ask patch coord-X coord-Y [         \n      (\n        ifelse\n        accumulated-energy-value <= EqualParts [ set pcolor white ] ;; low values of accumulated resource\n        accumulated-energy-value > EqualParts and accumulated-energy-value  <= SumEqualParts [ set pcolor green ];; intermediary values of accumulated resource\n        accumulated-energy-value > SumEqualParts [ set pcolor white ] ;; high values of accumulated resource\n      )\n    ]\n    set coord-X coord-X + 1\n  ]\n  set coord-Y coord-Y - 1\n  set coord-X min-pxcor\n]
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
BUTTON
400
148
695
181
Low values of accumulated resource
set ValueDiff MaxAccumulatedEnergyValue - MinAccumulatedEnergyValue \nset EqualParts ValueDiff / 3\nset EqualParts precision EqualParts 0 \nset SumEqualParts EqualParts + EqualParts \nlet coord-X min-pxcor\nlet coord-Y max-pycor\nwhile [ coord-Y >= min-pycor ] [\n  while [ coord-X <= max-pxcor ] [\n    ask patch coord-X coord-Y [         \n      (\n        ifelse\n        accumulated-energy-value <= EqualParts [ set pcolor gray ] ;; low values of accumulated resource\n        accumulated-energy-value > EqualParts and accumulated-energy-value  <= SumEqualParts [ set pcolor white ];; intermediary values of accumulated resource\n        accumulated-energy-value > SumEqualParts [ set pcolor white ] ;; high values of accumulated resource\n      )\n    ]\n    set coord-X coord-X + 1\n  ]\n  set coord-Y coord-Y - 1\n  set coord-X min-pxcor\n]\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
BUTTON
401
365
549
398
Colonies
ask colonies\n[  \n  ifelse hidden? = true\n  [ show-turtle ]\n  [ hide-turtle ]\n  set label \"\"\n]
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
BUTTON
548
365
696
398
Colony labels
ask colonies [\n  ifelse label = \"\" [    \n    set label  ( who )\n    set label-color white\n  ] \n  [    \n    set label \"\"\n  ]\n]\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
BUTTON
401
397
696
430
Colony profile codes
ask colonies [ \nifelse label = \"\" [\n        set label ( colony-profiles-code )\n        set label-color white\n      ] \n      [ \n        set label \"\"\n      ] \n]
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
BUTTON
402
440
697
473
Snapshot
snapshot
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
TEXTBOX
399
19
649
49
Display:
19
0.0
1
INPUTBOX
19
231
193
291
Repetitions
10.0
1
0
Number
INPUTBOX
192
231
368
291
num-LandscapeFiles
27.0
1
0
Number
SLIDER
19
290
368
323
BeeSize
BeeSize
1
10
2.0
1
1
mm
HORIZONTAL
SLIDER
19
341
369
374
Duration
Duration
1
100
20.0
1
1
ticks
HORIZONTAL
SLIDER
20
533
234
566
num-BeeColony-per-Profile
num-BeeColony-per-Profile
1
150
50.0
1
1
colonies
HORIZONTAL
BUTTON
233
533
370
566
Properties: profile colony
inspect colony 0
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1
MONITOR
20
565
234
610
total-BeeColonyProfilesNumber
count colonies
17
1
11
INPUTBOX
19
650
195
710
MaxMotherColonyDistance
50.0
1
0
Number
INPUTBOX
195
650
369
710
num-ColonyDivision
1.0
1
0
Number
TEXTBOX
22
623
172
643
Dispersion:
16
0.0
1
SWITCH
400
591
544
624
Output-Data-1?
Output-Data-1?
0
1
-1000
INPUTBOX
400
623
544
691
NameOutfile-Ouput-Data-1
PopulationDynamics
1
0
String
INPUTBOX
550
623
695
692
NameOutfile-Ouput-Data-2
BirthDistribuition
1
0
String
SWITCH
550
591
695
624
Output-Data-2?
Output-Data-2?
1
1
-1000
TEXTBOX
402
536
614
562
Create outfiles:
19
0.0
1
TEXTBOX
22
433
172
453
Profile colony types:
16
0.0
1
SWITCH
401
703
545
736
Output-Data-3?
Output-Data-3?
1
1
-1000
SWITCH
551
703
696
736
Output-Data-4?
Output-Data-4?
1
1
-1000
INPUTBOX
401
735
545
804
NameOutfile-Ouput-Data-3
DeathDistribuition
1
0
String
INPUTBOX
551
734
696
803
NameOutfile-Ouput-Data-4
SpatialDistribution
1
0
String
SLIDER
20
386
370
419
DurationConstance
DurationConstance
1
6
3.0
1
1
ticks
HORIZONTAL
MONITOR
233
565
370
610
ProfilesNumber
NumberProfiles
17
1
11
INPUTBOX
194
461
370
521
MinAccumulatedEnergyValue
-1060.0
1
0
Number
INPUTBOX
20
461
196
521
MaxAccumulatedEnergyValue
75164.0
1
0
Number
TEXTBOX
403
567
553
585
(requires \"Setup world\")
9
0.0
1
TEXTBOX
534
12
684
30
NIL
11
0.0
1
TEXTBOX
476
28
626
46
(requires \"Setup world\")
9
0.0
1
@#$#@#$#@
## WHAT IS IT?
The general purpose of BEEMOVE-ABM is: to model how structurally distinct agro-natural landscapes based in BEEFOR-ABM affect bee communities based on their ability to survive, reproduce and disperse.
## RECOMMENDATIONS
The ODD protocol will be available in the RLdaSS et al., 2022 thesis of the Federal University of Bahia, Brazil.
We recommend that any publication based on the use of BEEMOVE-ABM shall includes, in the Supplementary Material, the NetLogo file itself that was used and all input files. If you change these codes, we recommend documenting the changes in full detail and providing a revised description of the ODD model.
## CREDITS AND REFERENCES
If you mention this model or the NetLogo software in a publication, we ask that you include the citations below. For the model itself: RLdaSS et al., 2022: doctoral thesis from the Federal University of Bahia, Brazil, entitled: Effect of Landscape Heterogeneity on Bee Populations and Communities.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250
airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15
arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150
box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75
bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30
butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60
car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58
circle
false
0
Circle -7500403 true true 0 0 300
circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123
cylinder
false
0
Circle -7500403 true true 0 0 300
dot
false
0
Circle -7500403 true true 90 90 120
face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240
face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225
face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183
fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30
flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45
flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240
house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120
leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195
line
true
0
Line -7500403 true 150 0 150 300
line half
true
0
Line -7500403 true 150 0 150 150
mybeecolony
true
0
Rectangle -7500403 true true 105 105 195 120
Rectangle -7500403 true true 105 180 195 195
Rectangle -7500403 true true 90 165 210 180
Rectangle -7500403 true true 90 150 210 165
Rectangle -7500403 true true 90 135 210 150
Rectangle -7500403 true true 90 120 210 135
Rectangle -7500403 true true 120 90 180 105
Rectangle -7500403 true true 120 195 180 210
Line -16777216 false 120 105 105 105
Line -16777216 false 105 105 105 120
Line -16777216 false 105 120 90 120
Line -16777216 false 90 180 105 180
Line -16777216 false 105 180 105 195
Line -16777216 false 105 195 120 195
Line -16777216 false 120 195 120 210
Line -16777216 false 120 210 180 210
Line -16777216 false 180 210 180 195
Line -16777216 false 180 195 195 195
Line -16777216 false 195 195 195 180
Line -16777216 false 195 180 210 180
Line -16777216 false 195 120 210 120
Line -16777216 false 195 120 195 105
Line -16777216 false 195 105 180 105
Line -16777216 false 120 90 180 90
Circle -16777216 true false 135 150 30
Line -16777216 false 90 120 90 180
Line -16777216 false 210 180 210 120
Line -16777216 false 120 90 120 105
Line -16777216 false 180 105 180 90
pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120
person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105
plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90
sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83
square
false
0
Rectangle -7500403 true true 30 30 270 270
square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240
star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108
target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60
tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152
triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255
triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224
truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42
turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99
wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269
wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113
x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="BEEMOVE-ABM_2mm_EXPERIMENT" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>NumLandscapes = num-Landscapes AND ValidHabsItem = length ValidHabs AND ( count colonies = 0 OR ConstanceCounter = DurationConstance OR ticks = Duration )</exitCondition>
    <enumeratedValueSet variable="DurationConstance">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Output-Data-3?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MinAccumulatedEnergyValue">
      <value value="-1060"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num-LandscapeFiles">
      <value value="27"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="NameOutfile-Ouput-Data-1">
      <value value="&quot;PopulationDynamics&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num-ColonyDivision">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MaxAccumulatedEnergyValue">
      <value value="75164"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Output-Data-4?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="NameOutfile-Ouput-Data-2">
      <value value="&quot;BirthDistribuition&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Output-Data-1?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="NameOutfile-Ouput-Data-3">
      <value value="&quot;DeathDistribuition&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="NameOutfile-Ouput-Data-4">
      <value value="&quot;SpatialDistribution&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num-BeeColony-per-Profile">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Duration">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Output-Data-2?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MaxMotherColonyDistance">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="BeeSize">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Repetitions">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="EdgeSize">
      <value value="999"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Display?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ViewPatchSize">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="BEEMOVE-ABM_4mm_EXPERIMENT" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>NumLandscapes = num-Landscapes AND ValidHabsItem = length ValidHabs AND ( count colonies = 0 OR ConstanceCounter = DurationConstance OR ticks = Duration )</exitCondition>
    <enumeratedValueSet variable="DurationConstance">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Output-Data-3?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MinAccumulatedEnergyValue">
      <value value="-11376"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num-LandscapeFiles">
      <value value="27"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="NameOutfile-Ouput-Data-1">
      <value value="&quot;PopulationDynamics&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num-ColonyDivision">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MaxAccumulatedEnergyValue">
      <value value="149053"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Output-Data-4?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="NameOutfile-Ouput-Data-2">
      <value value="&quot;BirthDistribuition&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Output-Data-1?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="NameOutfile-Ouput-Data-3">
      <value value="&quot;DeathDistribuition&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="NameOutfile-Ouput-Data-4">
      <value value="&quot;SpatialDistribution&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num-BeeColony-per-Profile">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Duration">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Output-Data-2?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MaxMotherColonyDistance">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="BeeSize">
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Repetitions">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="EdgeSize">
      <value value="999"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Display?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ViewPatchSize">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="BEEMOVE-ABM_6mm_EXPERIMENT" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>NumLandscapes = num-Landscapes AND ValidHabsItem = length ValidHabs AND ( count colonies = 0 OR ConstanceCounter = DurationConstance OR ticks = Duration )</exitCondition>
    <enumeratedValueSet variable="DurationConstance">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Output-Data-3?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MinAccumulatedEnergyValue">
      <value value="-41745"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num-LandscapeFiles">
      <value value="27"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="NameOutfile-Ouput-Data-1">
      <value value="&quot;PopulationDynamics&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num-ColonyDivision">
      <value value="1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MaxAccumulatedEnergyValue">
      <value value="221973"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Output-Data-4?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="NameOutfile-Ouput-Data-2">
      <value value="&quot;BirthDistribuition&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Output-Data-1?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="NameOutfile-Ouput-Data-3">
      <value value="&quot;DeathDistribuition&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="NameOutfile-Ouput-Data-4">
      <value value="&quot;SpatialDistribution&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="num-BeeColony-per-Profile">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Duration">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Output-Data-2?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="MaxMotherColonyDistance">
      <value value="50"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="BeeSize">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Repetitions">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="EdgeSize">
      <value value="999"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Display?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="ViewPatchSize">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@