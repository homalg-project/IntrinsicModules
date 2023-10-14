# SPDX-License-Identifier: GPL-2.0-or-later
# IntrinsicModules: Finitely presented modules over computable rings allowing multiple presentations and the notion of elements
#
# Implementations
#

##
InstallGlobalFunction( INSTALL_HOMALG_STYLE_FUNCTIONS_FOR_FREYD_CATEGORY,
  function( A )
    
    ## Cokernels: cokernels in Freyd categories are formal and thus very cheap
    ##
    AddCokernelProjection( A,
      function( category, morphism )
        local range, relation_morphism, test_morphisms, diagram, cokernel_object, cokernel_projection;
        
        range := Target( morphism );
        
        relation_morphism := RelationMorphism( range );
        
        test_morphisms := [ MorphismDatum( morphism ), relation_morphism ];
        
        diagram := List( test_morphisms, Source );
        
        ## compared with FreydCategoriesForCAP and Construction 3.6
        ## in https://doi.org/10.1007/s10485-020-09612-y we switch the arguments
        ## [ MorphismDatum( morphism ), relation_morphism ] in order to increase the
        ## similarity to the output in ModulePresentationsForCAP and homalg_project/Modules
        cokernel_object := FreydCategoryObject( category,
                                   UniversalMorphismFromDirectSumWithGivenDirectSum(
                                           diagram,
                                           test_morphisms,
                                           DirectSum( diagram ) ) );
        
        return FreydCategoryMorphism( category,
                       range,
                       IdentityMorphism( Target( relation_morphism ) ),
                       cokernel_object );
        
    end );
    
    ## the following resembles the algorithm in CAP_project/ModulePresentationsForCAP
    ## in the form reached by commit fc8e92ee, in compliance with homalg_project/Modules
    ##
    AddKernelEmbedding( A, ## cf. the correspondig method in FreydCategoriesForCAP
      function( category, morphism )
        local alpha, rho_B, rho_A, emb, ker;
        
        alpha := MorphismDatum( morphism );
        
        rho_B := RelationMorphism( Target( morphism ) );
            
        rho_A := RelationMorphism( Source( morphism ) );
        
        emb := ProjectionOfBiasedRelativeWeakFiberProduct( alpha, rho_B, rho_A );
            
        ker := ProjectionOfBiasedWeakFiberProduct( emb, rho_A );
        
        emb :=
          FreydCategoryMorphism( category,
                  FreydCategoryObject( category, ker ),
                  emb,
                  FreydCategoryObject( category, rho_A ) );
        
        # check assertion
        Assert( 5, IsMonomorphism( emb ) );
        SetIsMonomorphism( emb, true );
        
        return emb;
        
    end );
    
    ## WitnessForBeingCongruentToZero calls Lift in CategoryOfRows/Columns,
    ## which in turn calls the two-argument RightDivide/LeftDivide in MatricesForHomalg.
    ## In case when the morphism passed to WitnessForBeingCongruentToZero is
    ## (the composition with) a cokernel projection (as in the two case
    ## AddLiftAlongMonomorphism or AddColiftAlongEpimorphism below),
    ## then the three-argument RightDivide/LeftDivide in MatricesForHomalg
    ## would be more efficient and would produce "smaller" output.
    
    ##
    #AddLiftAlongMonomorphism( A,
    #  function( category, alpha, test_morphism )
    #    local sigma, R_B, A, tau_A;
    #    
    #    sigma := WitnessForBeingCongruentToZero( PreCompose( test_morphism, CokernelProjection( alpha ) ) );
    #    
    #    R_B := Source( RelationMorphism( Target( alpha ) ) );
    #    
    #    A := Target( RelationMorphism( Source( alpha ) ) );
    #    
    #    ## the order in the list below depends on the order of list test_morphisms
    #    ## in the body of the function passed to AddCokernelProjection above
    #    tau_A := PreCompose( sigma, ProjectionInFactorOfDirectSum( [ A, R_B ], 1 ) );
    #    
    #    return FreydCategoryMorphism( category, Source( test_morphism ), tau_A, Source( alpha ) );
    #    
    #end );
        
    ##
    AddLiftAlongMonomorphism( A,
      function( category, monomorphism, test_morphism )
        local beta, alpha, N, chi;
        
        ## the notation below is borrowed from arXiv:1003.1943 Section 3.1.2
        beta := MorphismDatum( test_morphism );
        
        alpha := MorphismDatum( monomorphism );
        
        N := RelationMorphism( Target( monomorphism ) );
        
        chi := RelativeLift( beta, alpha, N );
        
        return FreydCategoryMorphism( category, Source( test_morphism ), chi, Source( monomorphism ) );
        
    end );
            
    ##
    #AddColiftAlongEpimorphism( A,
    #  function( category, alpha, test_morphism )
    #    local witness, R_B, A, sigma_A;
    #    
    #    witness := WitnessForBeingCongruentToZero( CokernelProjection( category, alpha ) );
    #    
    #    R_B := Source( RelationMorphism( Target( alpha ) ) );
    #    
    #    A := Target( RelationMorphism( Source( alpha ) ) );
    #    
    #    ## the order in the list below depends on the order of list test_morphisms
    #    ## in the body of the function passed to AddCokernelProjection above
    #    sigma_A := PreCompose( witness, ProjectionInFactorOfDirectSum( [ A, R_B ], 1 ) );
    #    
    #    return FreydCategoryMorphism( category, Target( alpha ), PreCompose( sigma_A, MorphismDatum( test_morphism ) ), Target( test_morphism ) );
    #    
    #end );
    
    ##
    AddColiftAlongEpimorphism( A,
      function( category, epimorphism, test_morphism )
        local beta, alpha, N, chi;
        
        ## the notation below is borrowed from arXiv:1003.1943 Section 3.1.2
        beta := MorphismDatum( IdentityMorphism( Target( epimorphism ) ) );
        
        alpha := MorphismDatum( epimorphism );
        
        N := RelationMorphism( Target( epimorphism ) );
        
        chi := RelativeLift( beta, alpha, N );
        
        return FreydCategoryMorphism( category, Target( epimorphism ), PreCompose( chi, MorphismDatum( test_morphism ) ), Target( test_morphism ) );
        
    end );

end );
