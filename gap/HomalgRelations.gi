####################################
#
# methods for operations:
#
####################################

##
InstallMethod( HasNrGenerators,
        "for a set of relations of homalg/CAP modules",
        [ IsHomalgRelations ],

  function( rel )
    local mat;
    
    mat := UnderlyingMatrix( rel );
    
    if IsLeftPresentation( rel ) then
        return HasNrColumns( mat );
    else
        return HasNrRows( mat );
    fi;
    
end );

##
InstallMethod( NrGenerators,
        "for a set of relations of homalg/CAP modules",
        [ IsHomalgRelations ],

  function( rel )
    local mat;
    
    mat := UnderlyingMatrix( rel );
    
    if IsLeftPresentation( rel ) then
        return NrColumns( mat );
    else
        return NrRows( mat );
    fi;
    
end );

##
InstallMethod( HasNrRelations,
        "for a set of relations of homalg/CAP modules",
        [ IsHomalgRelations and IsLeftOrRightPresentation ],

  function( rel )
    local mat;
    
    mat := UnderlyingMatrix( rel );
    
    if IsLeftPresentation( rel ) then
        return HasNrRows( mat );
    else
        return HasNrColumns( mat );
    fi;
    
end );

##
InstallMethod( NrRelations,
        "for a set of relations of a homalg/CAP module",
        [ IsHomalgRelations ],

  function( rel )
    local mat;
    
    mat := UnderlyingMatrix( rel );
    
    if IsLeftPresentation( rel ) then
        return NrRows( mat );
    else
        return NrColumns( mat );
    fi;
    
end );

##
InstallMethod( MatrixOfRelations,
        "for a set of relations of a homalg/CAP module",
        [ IsHomalgRelations and IsLeftOrRightPresentation ],
        
  function( M )
    
    return UnderlyingMatrix( M );
    
end );