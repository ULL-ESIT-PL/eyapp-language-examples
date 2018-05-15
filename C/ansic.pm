#!/usr/bin/perl
########################################################################################
#
#    This file was generated using Parse::Eyapp version 1.182.
#
# (c) Parse::Yapp Copyright 1998-2001 Francois Desarmenien.
# (c) Parse::Eyapp Copyright 2006-2008 Casiano Rodriguez-Leon. Universidad de La Laguna.
#        Don't edit this file, use source file 'ansic.eyp' instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
########################################################################################
package ansic;
use strict;

push @ansic::ISA, 'Parse::Eyapp::Driver';



  # Loading Parse::Eyapp::Driver
  BEGIN {
    unless (Parse::Eyapp::Driver->can('YYParse')) {
      eval << 'MODULE_Parse_Eyapp_Driver'
#
# Module Parse::Eyapp::Driver
#
# This module is part of the Parse::Eyapp package available on your
# nearest CPAN
#
# This module is based on Francois Desarmenien Parse::Yapp module
# (c) Parse::Yapp Copyright 1998-2001 Francois Desarmenien, all rights reserved.
# (c) Parse::Eyapp Copyright 2006-2010 Casiano Rodriguez-Leon, all rights reserved.

our $SVNREVISION = '$Rev: 2399M $';
our $SVNDATE     = '$Date: 2009-01-06 12:28:04 +0000 (mar, 06 ene 2009) $';

package Parse::Eyapp::Driver;

require 5.006;

use strict;

our ( $VERSION, $COMPATIBLE, $FILENAME );


# $VERSION is also in Parse/Eyapp.pm
$VERSION = "1.182";
$COMPATIBLE = '0.07';
$FILENAME   =__FILE__;

use Carp;
use Scalar::Util qw{blessed reftype looks_like_number};

use Getopt::Long;

#Known parameters, all starting with YY (leading YY will be discarded)
my (%params)=(YYLEX => 'CODE', 'YYERROR' => 'CODE', YYVERSION => '',
       YYRULES => 'ARRAY', YYSTATES => 'ARRAY', YYDEBUG => '', 
       # added by Casiano
       #YYPREFIX  => '',  # Not allowed at YYParse time but in new
       YYFILENAME => '', 
       YYBYPASS   => '',
       YYGRAMMAR  => 'ARRAY', 
       YYTERMS    => 'HASH',
       YYBUILDINGTREE  => '',
       YYACCESSORS => 'HASH',
       YYCONFLICTHANDLERS => 'HASH',
       YYSTATECONFLICT => 'HASH',
       YYLABELS => 'HASH',
       ); 
my (%newparams) = (%params, YYPREFIX => '',);

#Mandatory parameters
my (@params)=('LEX','RULES','STATES');

sub new {
    my($class)=shift;

    my($errst,$nberr,$token,$value,$check,$dotpos);

    my($self)={ 
      ERRST => \$errst,
      NBERR => \$nberr,
      TOKEN => \$token,
      VALUE => \$value,
      DOTPOS => \$dotpos,
      STACK => [],
      DEBUG => 0,
      PREFIX => "",
      CHECK => \$check, 
    };

  _CheckParams( [], \%newparams, \@_, $self );

    exists($$self{VERSION})
  and $$self{VERSION} < $COMPATIBLE
  and croak "Eyapp driver version $VERSION ".
        "incompatible with version $$self{VERSION}:\n".
        "Please recompile parser module.";

        ref($class)
    and $class=ref($class);

    unless($self->{ERROR}) {
      $self->{ERROR} = $class->error;
      $self->{ERROR} = \&_Error unless ($self->{ERROR});
    }

    unless ($self->{LEX}) {
        $self->{LEX} = $class->YYLexer;
        @params = ('RULES','STATES');
    }

    my $parser = bless($self,$class);

    $parser;
}

sub YYParse {
    my($self)=shift;
    my($retval);

  _CheckParams( \@params, \%params, \@_, $self );

  unless($self->{ERROR}) {
    $self->{ERROR} = $self->error;
    $self->{ERROR} = \&_Error unless ($self->{ERROR});
  }

  unless($self->{LEX}) {
    $self->{LEX} = $self->YYLexer;
    croak "Missing parameter 'yylex' " unless $self->{LEX} && reftype($self->{LEX}) eq 'CODE';
  }

  if($$self{DEBUG}) {
    _DBLoad();
    $retval = eval '$self->_DBParse()';#Do not create stab entry on compile
        $@ and die $@;
  }
  else {
    $retval = $self->_Parse();
  }
    return $retval;
}

sub YYData {
  my($self)=shift;

    exists($$self{USER})
  or  $$self{USER}={};

  $$self{USER};
  
}

sub YYErrok {
  my($self)=shift;

  ${$$self{ERRST}}=0;
    undef;
}

sub YYNberr {
  my($self)=shift;

  ${$$self{NBERR}};
}

sub YYRecovering {
  my($self)=shift;

  ${$$self{ERRST}} != 0;
}

sub YYAbort {
  my($self)=shift;

  ${$$self{CHECK}}='ABORT';
    undef;
}

sub YYAccept {
  my($self)=shift;

  ${$$self{CHECK}}='ACCEPT';
    undef;
}

# Used to set that we are in "error recovery" state
sub YYError {
  my($self)=shift;

  ${$$self{CHECK}}='ERROR';
    undef;
}

sub YYSemval {
  my($self)=shift;
  my($index)= $_[0] - ${$$self{DOTPOS}} - 1;

    $index < 0
  and -$index <= @{$$self{STACK}}
  and return $$self{STACK}[$index][1];

  undef;  #Invalid index
}

### Casiano methods

sub YYRule { 
  # returns the list of rules
  # counting the super rule as rule 0
  my $self = shift;
  my $index = shift;

  if ($index) {
    $index = $self->YYIndex($index) unless (looks_like_number($index));
    return wantarray? @{$self->{RULES}[$index]} : $self->{RULES}[$index]
  }

  return wantarray? @{$self->{RULES}} : $self->{RULES}
}

# YYState returns the list of states. Each state is an anonymous hash
#  DB<4> x $parser->YYState(2)
#  0  HASH(0xfa7120)
#     'ACTIONS' => HASH(0xfa70f0) # token => state
#           ':' => '-7'
#     'DEFAULT' => '-6'
# There are three keys: ACTIONS, GOTOS and  DEFAULT
#  DB<7> x $parser->YYState(13)
# 0  HASH(0xfa8b50)
#    'ACTIONS' => HASH(0xfa7530)
#       'VAR' => 17
#    'GOTOS' => HASH(0xfa8b20)
#       'type' => 19
sub YYState {
  my $self = shift;
  my $index = shift;

  if ($index) {
    # Comes from the stack: a pair [state number, attribute]
    $index = $index->[0] if 'ARRAY' eq reftype($index);
    die "YYState error. Expecting a number, found <$index>" unless (looks_like_number($index));
    return $self->{STATES}[$index]
  }

  return $self->{STATES}
}

sub YYGoto {
  my ($self, $state, $symbol) = @_;
 
  my $stateLRactions = $self->YYState($state);

  $stateLRactions->{GOTOS}{$symbol};
}

sub YYRHSLength {
  my $self = shift;
  # If no production index is given, is the production begin used in the current reduction
  my $index = shift || $self->YYRuleindex;

  # If the production was given by its name, compute its index
  $index = $self->YYIndex($index) unless looks_like_number($index); 
  
  return unless looks_like_number($index);

  my $currentprod = $self->YYRule($index);

  $currentprod->[1] if reftype($currentprod);
}

# To be used in a semantic action, when reducing ...
# It gives the next state after reduction
sub YYNextState {
  my $self = shift;

  my $lhs = $self->YYLhs;

  if ($lhs) { # reduce
    my $length = $self->YYRHSLength;

    my $state = $self->YYTopState($length);
    #print "state = $$state[0]\n";
    $self->YYGoto($state, $lhs);
  }
  else { # shift: a token must be provided as argument
    my $token = shift;
    
    my $state = $self->YYTopState;
    $self->YYGetLRAction($state, $token);
  }
}

# TODO: make it work with a list of indices ...
sub YYGrammar { 
  my $self = shift;
  my $index = shift;

  if ($index) {
    $index = $self->YYIndex($index) unless (looks_like_number($index));
    return wantarray? @{$self->{GRAMMAR}[$index]} : $self->{GRAMMAR}[$index]
  }
  return wantarray? @{$self->{GRAMMAR}} : $self->{GRAMMAR}
}

# Return the list of production names
sub YYNames { 
  my $self = shift;

  my @names = map { $_->[0] } @{$self->{GRAMMAR}};

  return wantarray? @names : \@names;
}

# Return the hash of indices  for each production name
# Initializes the INDICES attribute of the parser
# Returns the index of the production rule with name $name
sub YYIndex {
  my $self = shift;

  if (@_) {
    my @indices = map { $self->{LABELS}{$_} } @_;
    return wantarray? @indices : $indices[0];
  }
  return wantarray? %{$self->{LABELS}} : $self->{LABELS};

}

sub YYTopState {
  my $self = shift;
  my $length = shift || 0;

  $length = -$length unless $length <= 0;
  $length--;

  $_[1] and $self->{STACK}[$length] = $_[1];
  $self->{STACK}[$length];
}

sub YYStack {
  my $self = shift;

  return $self->{STACK};
}

# To dynamically set syntactic actions
# Change it to state, token, action
# it is more natural
sub YYSetLRAction {
  my ($self,  $state, $token, $action) = @_;

  die "YYLRAction: Provide a state " unless defined($state);

  # Action can be given using the name of the production
  $action = -$self->YYIndex($action) unless looks_like_number($action);
  $token = [ $token ] unless ref($token);
  for (@$token) {
    $self->{STATES}[$state]{ACTIONS}{$_} = $action;
  }
}

sub YYRestoreLRAction {
  my $self = shift;
  my $conflictname = shift;
  my @tokens = @_;

  for (@tokens) {
    my ($conflictstate, $action) = @{$self->{CONFLICT}{$conflictname}{$_}};
    $self->{STATES}[$conflictstate]{ACTIONS}{$_} = $action;
  }
}

# Fools the lexer to get a new token
# without modifying the parsing position (pos)
# Warning, warning! this and YYLookaheads assume
# that the input comes from the string
# referenced by $self->input.
# It will not work for a stream 
sub YYLookahead {
  my $self = shift;

  my $pos = pos(${$self->input});
  my ($nextToken, $val) = $self->YYLexer->($self);
  # restore pos
  pos(${$self->input}) = $pos;
  return $nextToken;
}

# Fools the lexer to get $spec new tokens
sub YYLookaheads {
  my $self = shift;
  my $spec = shift || 1; # a number

  my $pos = pos(${$self->input});
  my @r; # list of lookahead tokens

  my ($t, $v);
  if (looks_like_number($spec)) {
    for my $i (1..$spec) { 
      ($t, $v) = $self->YYLexer->($self);
      push @r, $t;
      last if $t eq '';
    }
  }
  else { # if string
    do {
      ($t, $v) = $self->YYLexer->($self);
      push @r, $t;
    } while ($t ne $spec && $t ne '');
  }

  # restore pos
  pos(${$self->input}) = $pos;

  return @r;
}


# more parameters: debug, etc, ...
#sub YYNestedParse {
sub YYPreParse {
  my $self = shift; 
  my $parser = shift;
  my $file = shift() || $parser;

  # Check for errors!
  eval "require $file";
   
  # optimize to state variable for 5.10
  my $rp = $parser->new( yyerror => sub {});

  my $pos  = pos(${$self->input});
  my $rpos = $self->{POS};

  #print "pos = $pos\n";
  $rp->input($self->input);
  pos(${$rp->input}) = $rpos;

  my $t = $rp->Run(@_);
  my $ne = $rp->YYNberr;

  #print "After nested parsing\n";

  pos(${$self->input}) = $pos;

  return (wantarray ? ($t, !$ne) : !$ne);
}

sub YYNestedParse {
  my $self = shift;
  my $parser = shift;
  my $conflictName =  shift;

  $conflictName = $self->YYLhs unless $conflictName;

  my ($t, $ok) = $self->YYPreParse($parser, @_);

  $self->{CONFLICTHANDLERS}{$conflictName}{".".$parser} = [$ok, $t];

  return $ok;
}

sub YYNestedRegexp {
  my $self = shift;
  my $regexp = shift;
  my $conflictName = $self->YYLhs;

  my $ok = $_ =~ /$regexp/gc;

  $self->{CONFLICTHANDLERS}{$conflictName}{'..regexp'} = [$ok, undef];

  return $ok;
}

sub YYIs {
  my $self = shift;
  # this is ungly and dangeorus. Don't use the dot. Change it!
  my $syntaxVariable = '.'.(shift());
  my $conflictName = $self->YYLhs;
  my $v = $self->{CONFLICTHANDLERS}{$conflictName};

  $v->{$syntaxVariable}[0] = shift if @_;
  return $v->{$syntaxVariable}[0];
}


sub YYVal {
  my $self = shift;
  # this is ungly and dangeorus. Don't use the dot. Change it!
  my $syntaxVariable = '.'.(shift());
  my $conflictName = $self->YYLhs;
  my $v = $self->{CONFLICTHANDLERS}{$conflictName};

  $v->{$syntaxVariable}[1] = shift if @_;
  return $v->{$syntaxVariable}[1];
}

#x $self->{CONFLICTHANDLERS}                                                                              
#0  HASH(0x100b306c0)
#   'rangeORenum' => HASH(0x100b30660)
#      'explorerline' => 12
#      'line' => 5
#      'production' => HASH(0x100b30580)
#         '-13' => ARRAY(0x100b30520)
#            0  1 <------- mark: conflictive position in the rhs 
#         '-5' => ARRAY(0x100b30550)
#            0  1 <------- mark: conflictive position in the rhs 
#      'states' => ARRAY(0x100b30630)
#         0  HASH(0x100b30600)
#            25 => ARRAY(0x100b305c0)
#               0  '\',\''
#               1  '\')\''
sub YYSetReduceXXXXX {
  my $self = shift;
  my $action = pop;
  my $token = shift;
  

  croak "YYSetReduce error: specify a production" unless defined($action);

  # Conflict state
  my $conflictstate = $self->YYNextState();

  my $conflictName = $self->YYLhs;

  #$self->{CONFLICTHANDLERS}{conflictName}{states}
  # is a hash
  #        statenumber => [ tokens, '\'-\'' ]
  my $cS = $self->{CONFLICTHANDLERS}{$conflictName}{states};
  my @conflictStates = $cS ? @$cS : ();

  # Perform the action to change the LALR tables only if the next state 
  # is listed as a conflictstate
  my ($cs) = (grep { exists $_->{$conflictstate}} @conflictStates); 
  return unless $cs;

  # Action can be given using the name of the production
  unless (looks_like_number($action)) {
    my $actionnum = $self->{LABELS}{$action};
    unless (looks_like_number($actionnum)) {
      croak "YYSetReduce error: can't find production '$action'. Did you forget to name it?";
    }
    $action = -$actionnum;
  }

  $token = $cs->{$conflictstate} unless defined($token);
  $token = [ $token ] unless ref($token);
  for (@$token) {
    # save if shift
    if (exists($self->{STATES}[$conflictstate]{ACTIONS}) and $self->{STATES}[$conflictstate]{ACTIONS}{$_} >= 0) {
      $self->{CONFLICT}{$conflictName}{$_}  = [ $conflictstate,  $self->{STATES}[$conflictstate]{ACTIONS}{$_} ];
    }
    $self->{STATES}[$conflictstate]{ACTIONS}{$_} = $action;
  }
}

sub YYSetReduce {
  my $self = shift;
  my $action = pop;
  my $token = shift;
  

  croak "YYSetReduce error: specify a production" unless defined($action);

  my $conflictName = $self->YYLhs;

  #$self->{CONFLICTHANDLERS}{conflictName}{states}
  # is a hash
  #        statenumber => [ tokens, '\'-\'' ]
  my $cS = $self->{CONFLICTHANDLERS}{$conflictName}{states};
  my @conflictStates = $cS ? @$cS : ();
 
  return unless @conflictStates;

  # Conflict state
  my $cs = $conflictStates[0];


  my ($conflictstate) = keys %{$cs};

  # Action can be given using the name of the production
  unless (looks_like_number($action)) {
    my $actionnum = $self->{LABELS}{$action};
    unless (looks_like_number($actionnum)) {
      croak "YYSetReduce error: can't find production '$action'. Did you forget to name it?";
    }
    $action = -$actionnum;
  }

  $token = $cs->{$conflictstate} unless defined($token);
  $token = [ $token ] unless ref($token);
  for (@$token) {
    # save if shift
    if (exists($self->{STATES}[$conflictstate]{ACTIONS}) and $self->{STATES}[$conflictstate]{ACTIONS}{$_} >= 0) {
      $self->{CONFLICT}{$conflictName}{$_}  = [ $conflictstate,  $self->{STATES}[$conflictstate]{ACTIONS}{$_} ];
    }
    $self->{STATES}[$conflictstate]{ACTIONS}{$_} = $action;
  }
}

sub YYSetShift {
  my ($self, $token) = @_;

  # my ($self, $token, $action) = @_;
  # $action is syntactic sugar ...


  my $conflictName = $self->YYLhs;

  my $cS = $self->{CONFLICTHANDLERS}{$conflictName}{states};
  my @conflictStates = $cS ? @$cS : ();
 
  return unless @conflictStates;

  my $cs = $conflictStates[0];

  my ($conflictstate) = keys %{$cs};

  $token = $cs->{$conflictstate} unless defined($token);
  $token = [ $token ] unless ref($token);

  for (@$token) {
    if (defined($self->{CONFLICT}{$conflictName}{$_}))  {
      my ($conflictstate2, $action) = @{$self->{CONFLICT}{$conflictName}{$_}};
      # assert($conflictstate == $conflictstate2) 

      $self->{STATES}[$conflictstate]{ACTIONS}{$_} = $self->{CONFLICT}{$conflictName}{$_}[1];
    }
    else {
      #croak "YYSetShift error. No shift action found";
      # shift is the default ...  hope to be lucky!
    }
  }
}


  # if is reduce ...
    # x $self->{CONFLICTHANDLERS}{$conflictName}{production}{$action} $action is a number
    #0  ARRAY(0x100b3f930)
    #   0  2
    # has the position in the item, starting at 0
    # DB<19> x $self->YYRHSLength(4)
    # 0  3
    # if pos is length -1 then is reduce otherwise is shift


# It does YYSetReduce or YYSetshift according to the 
# decision variable
# I need to know the kind of conflict that there is
# shift-reduce or reduce-reduce
sub YYIf {
  my $self = shift;
  my $syntaxVariable = shift;

  if ($self->YYIs($syntaxVariable)) {
    if ($_[0] eq 'shift') {
      $self->YYSetShift(@_); 
    }
    else {
      $self->YYSetReduce($_[0]); 
    }
  }
  else {
    if ($_[1] eq 'shift') {
      $self->YYSetShift(@_); 
    }
    else {
      $self->YYSetReduce($_[1]); 
    }
  }
  $self->YYIs($syntaxVariable, 0); 
}

sub YYGetLRAction {
  my ($self,  $state, $token) = @_;

  $state = $state->[0] if reftype($state) && (reftype($state) eq 'ARRAY');
  my $stateentry = $self->{STATES}[$state];

  if (defined($token)) {
    return $stateentry->{ACTIONS}{$token} if exists $stateentry->{ACTIONS}{$token};
  }

  return $stateentry->{DEFAULT} if exists $stateentry->{DEFAULT};

  return;
}

# to dynamically set semantic actions
sub YYAction {
  my $self = shift;
  my $index = shift;
  my $newaction = shift;

  croak "YYAction error: Expecting an index" unless $index;

  # If $index is the production 'name' find the actual index
  $index = $self->YYIndex($index) unless looks_like_number($index);
  my $rule = $self->{RULES}->[$index];
  $rule->[2] = $newaction if $newaction && (reftype($newaction) eq 'CODE');

  return $rule->[2];
}

sub YYSetaction {
  my $self = shift;
  my %newaction = @_;

  for my $n (keys(%newaction)) {
    my $m = looks_like_number($n) ? $n : $self->YYIndex($n);
    my $rule = $self->{RULES}->[$m];
    $rule->[2] = $newaction{$n} if ($newaction{$n} && (reftype($newaction{$n}) eq 'CODE'));
  }
}

#sub YYDebugtree  {
#  my ($self, $i, $e) = @_;
#
#  my ($name, $lhs, $rhs) = @$e;
#  my @rhs = @$rhs;
#
#  return if $name =~ /_SUPERSTART/;
#  $name = $lhs."::"."@rhs";
#  $name =~ s/\W/_/g;
#  return $name;
#}
#
#sub YYSetnames {
#  my $self = shift;
#  my $newname = shift || \&YYDebugtree;
#
#    die "YYSetnames error. Exected a CODE reference found <$newname>" 
#  unless $newname && (reftype($newname) eq 'CODE');
#
#  my $i = 0;
#  for my $e (@{$self->{GRAMMAR}}) {
#     my $nn= $newname->($self, $i, $e);
#     $e->[0] = $nn if defined($nn);
#     $i++;
#  }
#}

sub YYLhs { 
  # returns the syntax variable on
  # the left hand side of the current production
  my $self = shift;

  return $self->{CURRENT_LHS}
}

sub YYRuleindex { 
  # returns the index of the rule
  # counting the super rule as rule 0
  my $self = shift;

  return $self->{CURRENT_RULE}
}

sub YYRightside { 
  # returns the rule
  # counting the super rule as rule 0
  my $self = shift;
  my $index = shift || $self->{CURRENT_RULE};
  $index = $self->YYIndex($index) unless looks_like_number($index);

  return @{$self->{GRAMMAR}->[$index]->[2]};
}

sub YYTerms {
  my $self = shift;

  return $self->{TERMS};
}


sub YYIsterm {
  my $self = shift;
  my $symbol = shift;

  return exists ($self->{TERMS}->{$symbol});
}

sub YYIssemantic {
  my $self = shift;
  my $symbol = shift;

  return 0 unless exists($self->{TERMS}{$symbol});
  $self->{TERMS}{$symbol}{ISSEMANTIC} = shift if @_;
  return ($self->{TERMS}{$symbol}{ISSEMANTIC});
}

sub YYName {
  my $self = shift;

  my $current_rule = $self->{GRAMMAR}->[$self->{CURRENT_RULE}];
  $current_rule->[0] = shift if @_;
  return $current_rule->[0];
}

sub YYPrefix {
  my $self = shift;

  $self->{PREFIX} = $_[0] if @_;
  $self->{PREFIX};
}

sub YYAccessors {
  my $self = shift;

  $self->{ACCESSORS}
}

# name of the file containing
# the source grammar
sub YYFilename {
  my $self = shift;

  $self->{FILENAME} = $_[0] if @_;
  $self->{FILENAME};
}

sub YYBypass {
  my $self = shift;

  $self->{BYPASS} = $_[0] if @_;
  $self->{BYPASS};
}

sub YYBypassrule {
  my $self = shift;

  $self->{GRAMMAR}->[$self->{CURRENT_RULE}][3] = $_[0] if @_;
  return $self->{GRAMMAR}->[$self->{CURRENT_RULE}][3];
}

sub YYFirstline {
  my $self = shift;

  $self->{FIRSTLINE} = $_[0] if @_;
  $self->{FIRSTLINE};
}

# Used as default action when writing a reusable grammar.
# See files examples/recycle/NoacInh.eyp 
# and examples/recycle/icalcu_and_ipost.pl 
# in the Parse::Eyapp distribution
sub YYDelegateaction {
  my $self = shift;

  my $action = $self->YYName;
  
  $self->$action(@_);
}

# Influences the behavior of YYActionforT_X1X2
# YYActionforT_single and YYActionforT_empty
# If true these methods will build simple lists of attributes 
# for the lists operators X*, X+ and X? and parenthesis (X Y)
# Otherwise the classic node construction for the
# syntax tree is used
sub YYBuildingTree {
  my $self = shift;

  $self->{BUILDINGTREE} = $_[0] if @_;
  $self->{BUILDINGTREE};
}

sub BeANode {
  my $class = shift;

    no strict 'refs';
    push @{$class."::ISA"}, "Parse::Eyapp::Node" unless $class->isa("Parse::Eyapp::Node");
}

#sub BeATranslationScheme {
#  my $class = shift;
#
#    no strict 'refs';
#    push @{$class."::ISA"}, "Parse::Eyapp::TranslationScheme" unless $class->isa("Parse::Eyapp::TranslationScheme");
#}

{
  my $attr =  sub { 
      $_[0]{attr} = $_[1] if @_ > 1;
      $_[0]{attr}
    };

  sub make_node_classes {
    my $self = shift;
    my $prefix = $self->YYPrefix() || '';

    { no strict 'refs';
      *{$prefix."TERMINAL::attr"} = $attr;
    }

    for (@_) {
       my ($class) = split /:/, $_;
       BeANode("$prefix$class"); 
    }

    my $accessors = $self->YYAccessors();
    for (keys %$accessors) {
      my $position = $accessors->{$_};
      no strict 'refs';
      *{$prefix.$_} = sub {
        my $self = shift;

        return $self->child($position, @_)
      }
    } # for
  }
}

####################################################################
# Usage      : ????
# Purpose    : Responsible for the %tree directive 
#              On each production the default action becomes:
#              sub { goto &Parse::Eyapp::Driver::YYBuildAST }
#
# Returns    : ????
# Parameters : ????
# Throws     : no exceptions
# Comments   : none
# See Also   : n/a
# To Do      : many things: Optimize this!!!!
sub YYBuildAST { 
  my $self = shift;
  my $PREFIX = $self->YYPrefix();
  my @right = $self->YYRightside(); # Symbols on the right hand side of the production
  my $lhs = $self->YYLhs;
  my $fullname = $self->YYName();
  my ($name) = split /:/, $fullname;
  my $bypass = $self->YYBypassrule; # Boolean: shall we do bypassing of lonely nodes?
  my $class = "$PREFIX$name";
  my @children;

  my $node = bless {}, $class;

  for(my $i = 0; $i < @right; $i++) {
    local $_ = $right[$i]; # The symbol
    my $ch = $_[$i]; # The attribute/reference

    # is $ch already a Parse::Eyapp::Node. May be a terminal and a syntax variable share the same name?
    unless (UNIVERSAL::isa($ch, 'Parse::Eyapp::Node')) {
      if ($self->YYIssemantic($_)) {
        my $class = $PREFIX.'TERMINAL';
        my $node = bless { token => $_, attr => $ch, children => [] }, $class;
        push @children, $node;
        next;
      }

      if ($self->YYIsterm($_)) {
        TERMINAL::save_attributes($ch, $node) if UNIVERSAL::can($PREFIX."TERMINAL", "save_attributes");
        next;
      }
    }

    if (UNIVERSAL::isa($ch, $PREFIX."_PAREN")) { # Warning: weak code!!!
      push @children, @{$ch->{children}};
      next;
    }

    # If it is an intermediate semantic action skip it
    next if $_ =~ qr{@}; # intermediate rule
    next unless ref($ch);
    push @children, $ch;
  }

  
  if ($bypass and @children == 1) {
    $node = $children[0]; 

    my $childisterminal = ref($node) =~ /TERMINAL$/;
    # Re-bless unless is "an automatically named node", but the characterization of this is 
    bless $node, $class unless $name =~ /${lhs}_\d+$/; # lazy, weak (and wicked).

   
    my $finalclass =  ref($node);
    $childisterminal and !$finalclass->isa($PREFIX.'TERMINAL') 
      and do { 
        no strict 'refs';
        push @{$finalclass."::ISA"}, $PREFIX.'TERMINAL' 
      };

    return $node;
  }
  $node->{children} = \@children; 
  return $node;
}

sub YYBuildTS { 
  my $self = shift;
  my $PREFIX = $self->YYPrefix();
  my @right = $self->YYRightside(); # Symbols on the right hand side of the production
  my $lhs = $self->YYLhs;
  my $fullname = $self->YYName();
  my ($name) = split /:/, $fullname;
  my $class;
  my @children;

  for(my $i = 0; $i < @right; $i++) {
    local $_ = $right[$i]; # The symbol
    my $ch = $_[$i]; # The attribute/reference

    if ($self->YYIsterm($_)) { 
      $class = $PREFIX.'TERMINAL';
      push @children, bless { token => $_, attr => $ch, children => [] }, $class;
      next;
    }

    if (UNIVERSAL::isa($ch, $PREFIX."_PAREN")) { # Warning: weak code!!!
      push @children, @{$ch->{children}};
      next;
    }

    # Substitute intermediate code node _CODE(CODE()) by CODE()
    if (UNIVERSAL::isa($ch, $PREFIX."_CODE")) { # Warning: weak code!!!
      push @children, $ch->child(0);
      next;
    }

    next unless ref($ch);
    push @children, $ch;
  }

  if (unpack('A1',$lhs) eq '@') { # class has to be _CODE check
          $lhs =~ /^\@[0-9]+\-([0-9]+)$/
      or  croak "In line rule name '$lhs' ill formed: report it as a BUG.\n";
      my $dotpos = $1;
 
      croak "Fatal error building metatree when processing  $lhs -> @right" 
      unless exists($_[$dotpos]) and UNIVERSAL::isa($_[$dotpos], 'CODE') ; 
      push @children, $_[$dotpos];
  }
  else {
    my $code = $_[@right];
    if (UNIVERSAL::isa($code, 'CODE')) {
      push @children, $code; 
    }
    else {
      croak "Fatal error building translation scheme. Code or undef expected" if (defined($code));
    }
  }

  $class = "$PREFIX$name";
  my $node = bless { children => \@children }, $class; 
  $node;
}

sub YYActionforT_TX1X2_tree {
  my $self = shift;
  my $head = shift;
  my $PREFIX = $self->YYPrefix();
  my @right = $self->YYRightside();
  my $class;

  for(my $i = 1; $i < @right; $i++) {
    local $_ = $right[$i];
    my $ch = $_[$i-1];
    if ($self->YYIssemantic($_)) {
      $class = $PREFIX.'TERMINAL';
      push @{$head->{children}}, bless { token => $_, attr => $ch, children => [] }, $class;
      
      next;
    }
    next if $self->YYIsterm($_);
    if (ref($ch) eq  $PREFIX."_PAREN") { # Warning: weak code!!!
      push @{$head->{children}}, @{$ch->{children}};
      next;
    }
    next unless ref($ch);
    push @{$head->{children}}, $ch;
  }

  return $head;
}

# For * and + lists 
# S2 -> S2 X         { push @$_[1] the node associated with X; $_[1] }
# S2 -> /* empty */  { a node with empty children }
sub YYActionforT_TX1X2 {
  goto &YYActionforT_TX1X2_tree if $_[0]->YYBuildingTree;

  my $self = shift;
  my $head = shift;

  push @$head, @_;
  return $head;
}

sub YYActionforParenthesis {
  goto &YYBuildAST if $_[0]->YYBuildingTree;

  my $self = shift;

  return [ @_ ];
}


sub YYActionforT_empty_tree {
  my $self = shift;
  my $PREFIX = $self->YYPrefix();
  my $name = $self->YYName();

  # Allow use of %name
  my $class = $PREFIX.$name;
  my $node = bless { children => [] }, $class;
  #BeANode($class);
  $node;
}

sub YYActionforT_empty {
  goto &YYActionforT_empty_tree  if $_[0]->YYBuildingTree;

  [];
}

sub YYActionforT_single_tree {
  my $self = shift;
  my $PREFIX = $self->YYPrefix();
  my $name = $self->YYName();
  my @right = $self->YYRightside();
  my $class;

  # Allow use of %name
  my @t;
  for(my $i = 0; $i < @right; $i++) {
    local $_ = $right[$i];
    my $ch = $_[$i];
    if ($self->YYIssemantic($_)) {
      $class = $PREFIX.'TERMINAL';
      push @t, bless { token => $_, attr => $ch, children => [] }, $class;
      #BeANode($class);
      next;
    }
    next if $self->YYIsterm($_);
    if (ref($ch) eq  $PREFIX."_PAREN") { # Warning: weak code!!!
      push @t, @{$ch->{children}};
      next;
    }
    next unless ref($ch);
    push @t, $ch;
  }
  $class = $PREFIX.$name;
  my $node = bless { children => \@t }, $class;
  #BeANode($class);
  $node;
}

sub YYActionforT_single {
  goto &YYActionforT_single_tree  if $_[0]->YYBuildingTree;

  my $self = shift;
  [ @_ ];
}

### end Casiano methods

sub YYCurtok {
  my($self)=shift;

        @_
    and ${$$self{TOKEN}}=$_[0];
    ${$$self{TOKEN}};
}

sub YYCurval {
  my($self)=shift;

        @_
    and ${$$self{VALUE}}=$_[0];
    ${$$self{VALUE}};
}

{
  sub YYSimStack {
    my $self = shift;
    my $stack = shift;
    my @reduce = @_;
    my @expected;

    for my $index (@reduce) {
      my ($lhs, $length) = @{$self->{RULES}[-$index]};
      if (@$stack > $length) {
        my @auxstack = @$stack;
        splice @auxstack, -$length if $length;

        my $state = $auxstack[-1]->[0];
        my $nextstate = $self->{STATES}[$state]{GOTOS}{$lhs};
        if (defined($nextstate)) {
          push @auxstack, [$nextstate, undef];
          push @expected, $self->YYExpected(\@auxstack);
        }
      }
      # else something went wrong!!! See Frank Leray report
    }

    return map { $_ => 1 } @expected;
  }

  sub YYExpected {
    my($self)=shift;
    my $stack = shift;

    # The state in the top of the stack
    my $state = $self->{STATES}[$stack->[-1][0]];

    my %actions;
    %actions = %{$state->{ACTIONS}} if exists $state->{ACTIONS};

    # The keys of %reduction are the -production numbers
    # Use hashes and not lists to guarantee that no tokens are repeated
    my (%expected, %reduce); 
    for (keys(%actions)) {
      if ($actions{$_} > 0) { # shift
        $expected{$_} = 1;
        next;
      }
      $reduce{$actions{$_}} = 1;
    }
    $reduce{$state->{DEFAULT}} = 1 if exists($state->{DEFAULT});

    if (keys %reduce) {
      %expected = (%expected, $self->YYSimStack($stack, keys %reduce));
    }
    
    return keys %expected;
  }

  sub YYExpect {
    my $self = shift;
    $self->YYExpected($self->{STACK}, @_);
  }
}

# $self->expects($token) : returns true if the token is among the expected ones
sub expects {
  my $self = shift;
  my $token = shift;

  my @expected = $self->YYExpect;
  return grep { $_ eq $token } @expected;
}

BEGIN {
*YYExpects = \&expects;
}

# Set/Get a static/class attribute for $class
# Searches the $class ancestor tree for  an ancestor
# having defined such attribute. If found, that value is returned
sub static_attribute { 
    my $class = shift;
    $class = ref($class) if ref($class);
    my $attributename = shift;

    # class/static method
    no strict 'refs';
    my $classlexer;
    my $classname = $classlexer = $class.'::'.$attributename;
    if (@_) {
      ${$classlexer} = shift;
    }

    return ${$classlexer} if defined($$classlexer);
   
    # Traverse the inheritance tree for a defined
    # version of the attribute
    my @classes = @{$class.'::ISA'};
    my %classes = map { $_ => undef } @classes;
    while (@classes) {
      my $c = shift @classes || return;  
      $classlexer = $c.'::'.$attributename;
      if (defined($$classlexer)) {
        $$classname = $$classlexer;
        return $$classlexer;
      }
      # push those that aren't already there
      push @classes, grep { !exists $classes{$_} } @{$c.'::ISA'};
    }
    return undef;
}

sub YYEndOfInput {
   my $self = shift;

   for (${$self->input}) {
     return !defined($_) || ($_ eq '') || (defined(pos($_)) && (pos($_) >= length($_)));
   }
}

#################
# Private stuff #
#################


sub _CheckParams {
  my ($mandatory,$checklist,$inarray,$outhash)=@_;
  my ($prm,$value);
  my ($prmlst)={};

  while(($prm,$value)=splice(@$inarray,0,2)) {
        $prm=uc($prm);
      exists($$checklist{$prm})
    or  croak("Unknown parameter '$prm'");
      ref($value) eq $$checklist{$prm}
    or  croak("Invalid value for parameter '$prm'");
        $prm=unpack('@2A*',$prm);
    $$outhash{$prm}=$value;
  }
  for (@$mandatory) {
      exists($$outhash{$_})
    or  croak("Missing mandatory parameter '".lc($_)."'");
  }
}

#################### TailSupport ######################
sub line {
  my $self = shift;

  if (ref($self)) {
    $self->{TOKENLINE} = shift if @_;

    return $self->static_attribute('TOKENLINE', @_,) unless defined($self->{TOKENLINE}); # class/static method 
    return $self->{TOKENLINE};
  }
  else { # class/static method
    return $self->static_attribute('TOKENLINE', @_,); # class/static method 
  }
}

# attribute to count the lines
sub tokenline {
  my $self = shift;

  if (ref($self)) {
    $self->{TOKENLINE} += shift if @_;

    return $self->static_attribute('TOKENLINE', @_,) unless defined($self->{TOKENLINE}); # class/static method 
    return $self->{TOKENLINE};
  }
  else { # class/static method
    return $self->static_attribute('TOKENLINE', @_,); # class/static method 
  }
}

our $ERROR = \&_Error;
sub error {
  my $self = shift;

  if (ref $self) { # instance method
    $self->{ERROR} = shift if @_;

    return $self->static_attribute('ERROR', @_,) unless defined($self->{ERROR}); # class/static method 
    return $self->{ERROR};
  }
  else { # class/static method
    return $self->static_attribute('ERROR', @_,); # class/static method 
  }
}

# attribute with the input
# is a reference to the actual input
# slurp_file. 
# Parameters: object or class, filename, prompt messagge, mode (interactive or not: undef or "\n")
*YYSlurpFile = \&slurp_file;
sub slurp_file {
  my $self = shift;
  my $fn = shift;
  my $f;

  my $mode = undef;
  if ($fn && -r $fn) {
    open $f, $fn  or die "Can't find file '$fn'!\n";
  }
  else {
    $f = \*STDIN;
    my $msg = $self->YYPrompt();
    $mode = shift;
    print($msg) if $msg;
  }
  $self->YYInputFile($f);

  local $/ = $mode;
  my $input = <$f>;

  if (ref($self)) {  # called as object method
    $self->input(\$input);
  }
  else { # class/static method
    my $classinput = $self.'::input';
    ${$classinput}->input(\$input);
  }
}

our $INPUT = \undef;
*Parse::Eyapp::Driver::YYInput = \&input;
sub input {
  my $self = shift;

  $self->line(1) if @_; # used as setter
  if (ref $self) { # instance method
    if (@_) {
      if (ref $_[0]) {
        $self->{INPUT} = shift;
      }
      else {
        my $input = shift;
        $self->{INPUT} = \$input;
      }
    }

    return $self->static_attribute('INPUT', @_,) unless defined($self->{INPUT}); # class/static method 
    return $self->{INPUT};
  }
  else { # class/static method
    return $self->static_attribute('INPUT', @_,); # class/static method 
  }
}
*YYInput = \&input;  # alias

# Opened file used to get the input
# static and instance method
our $INPUTFILE = \*STDIN;
sub YYInputFile {
  my $self = shift;

  if (ref($self)) { # object method
     my $file = shift;
     if ($file) { # setter
       $self->{INPUTFILE} = $file;
     }
    
    return $self->static_attribute('INPUTFILE', @_,) unless defined($self->{INPUTFILE}); # class/static method 
    return $self->{INPUTFILE};
  }
  else { # static
    return $self->static_attribute('INPUTFILE', @_,); # class/static method 
  }
}


our $PROMPT;
sub YYPrompt {
  my $self = shift;

  if (ref($self)) { # object method
     my $prompt = shift;
     if ($prompt) { # setter
       $self->{PROMPT} = $prompt;
     }
    
    return $self->static_attribute('PROMPT', @_,) unless defined($self->{PROMPT}); # class/static method 
    return $self->{PROMPT};
  }
  else { # static
    return $self->static_attribute('PROMPT', @_,); # class/static method 
  }
}

# args: parser, debug and optionally the input or a reference to the input
sub Run {
  my ($self) = shift;
  my $yydebug = shift;
  
  if (defined($_[0])) {
    if (ref($_[0])) { # if arg is a reference
      $self->input(shift());
    }
    else { # arg isn't a ref: make a copy
      my $x = shift();
      $self->input(\$x);
    }
  }
  croak "Provide some input for parsing" unless ($self->input && defined(${$self->input()}));
  return $self->YYParse( 
    #yylex => $self->lexer(), 
    #yyerror => $self->error(),
    yydebug => $yydebug, # 0xF
  );
}
*Parse::Eyapp::Driver::YYRun = \&run;

# args: class, prompt, file, optionally input (ref or not)
# return the abstract syntax tree (or whatever was returned by the parser)
*Parse::Eyapp::Driver::YYMain = \&main;
sub main {
  my $package = shift;
  my $prompt = shift;

  my $debug = 0;
  my $file = '';
  my $showtree = 0;
  my $TERMINALinfo;
  my $help;
  my $slurp;
  my $inputfromfile = 1;
  my $commandinput = '';
  my $quotedcommandinput = '';
  my $yaml = 0;
  my $dot = 0;

  my $result = GetOptions (
    "debug!"         => \$debug,         # sets yydebug on
    "file=s"         => \$file,          # read input from that file
    "commandinput=s" => \$commandinput,  # read input from command line arg
    "tree!"          => \$showtree,      # prints $tree->str
    "info"           => \$TERMINALinfo,  # prints $tree->str and provides default TERMINAL::info
    "help"           => \$help,          # shows SYNOPSIS section from the script pod
    "slurp!"         => \$slurp,         # read until EOF or CR is reached
    "argfile!"       => \$inputfromfile, # take input string from @_
    "yaml"           => \$yaml,          # dumps YAML for $tree: YAML must be installed
    "dot=s"          => \$dot,          # dumps YAML for $tree: YAML must be installed
    "margin=i"       => \$Parse::Eyapp::Node::INDENT,      
  );

  $package->_help() if $help;

  $debug = 0x1F if $debug;
  $file = shift if !$file && @ARGV; # file is taken from the @ARGV unless already defined
  $slurp = "\n" if defined($slurp);

  my $parser = $package->new();
  $parser->YYPrompt($prompt) if defined($prompt);

  if ($commandinput) {
    $parser->input(\$commandinput);
  }
  elsif ($inputfromfile) {
    $parser->slurp_file( $file, $slurp);
  }
  else { # input must be a string argument
    croak "No input provided for parsing! " unless defined($_[0]);
    if (ref($_[0])) {
      $parser->input(shift());
    }
    else {
      my $x = shift();
      $parser->input(\$x);
    }
  }

  if (defined($TERMINALinfo)) {
    my $prefix = ($parser->YYPrefix || '');
    no strict 'refs';
    *{$prefix.'TERMINAL::info'} = sub { 
      (ref($_[0]->attr) eq 'ARRAY')? $_[0]->attr->[0] : $_[0]->attr 
    };
  }

  my $tree = $parser->Run( $debug, @_ );

  if (my $ne = $parser->YYNberr > 0) {
    print "There were $ne errors during parsing\n";
    return undef;
  }
  else {
    if ($showtree) {
      if ($tree && blessed $tree && $tree->isa('Parse::Eyapp::Node')) {

          print $tree->str()."\n";
      }
      elsif ($tree && ref $tree) {
        require Data::Dumper;
        print Data::Dumper::Dumper($tree)."\n";
      }
      elsif (defined($tree)) {
        print "$tree\n";
      }
    }
    if ($yaml && ref($tree)) {
      eval {
        require YAML;
      };
      if ($@) {
        print "You must install 'YAML' to use this option\n";
      }
      else {
        YAML->import;
        print Dump($tree);
      }
    }
    if ($dot && blessed($tree)) {
      my ($sfile, $extension) = $dot =~ /^(.*)\.([^.]*)$/;
      $extension = 'png' unless (defined($extension) and $tree->can($extension));
      ($sfile) = $file =~ m{(.*[^.])} if !defined($sfile) and defined($file);
      $tree->$extension($sfile);
    }

    return $tree
  }
}

sub _help {
  my $package = shift;

  print << 'AYUDA';
Available options:
    --debug                    sets yydebug on
    --nodebug                  sets yydebug off
    --file filepath            read input from filepath
    --commandinput string      read input from string
    --tree                     prints $tree->str
    --notree                   does not print $tree->str
    --info                     When printing $tree->str shows the value of TERMINALs
    --help                     shows this help
    --slurp                    read until EOF reached
    --noslurp                  read until CR is reached
    --argfile                  main() will take the input string from its @_
    --noargfile                main() will not take the input string from its @_
    --yaml                     dumps YAML for $tree: YAML module must be installed
    --margin=i                 controls the indentation of $tree->str (i.e. $Parse::Eyapp::Node::INDENT)      
    --dot format               produces a .dot and .format file (png,jpg,bmp, etc.)
AYUDA

  $package->help() if ($package & $package->can("help"));

  exit(0);
}

# Generic error handler
# Convention adopted: if the attribute of a token is an object
# assume it has 'line' and 'str' methods. Otherwise, if it
# is an array, follows the convention [ str, line, ...]
# otherwise is just an string representing the value of the token
sub _Error {
  my $parser = shift;

  my $yydata = $parser->YYData;

    exists $yydata->{ERRMSG}
  and do {
      warn $yydata->{ERRMSG};
      delete $yydata->{ERRMSG};
      return;
  };

  my ($attr)=$parser->YYCurval;

  my $stoken = '';

  if (blessed($attr) && $attr->can('str')) {
     $stoken = " near '".$attr->str."'"
  }
  elsif (ref($attr) eq 'ARRAY') {
    $stoken = " near '".$attr->[0]."'";
  }
  else {
    if ($attr) {
      $stoken = " near '$attr'";
    }
    else {
      $stoken = " near end of input";
    }
  }

  my @expected = map { ($_ ne '')? "'$_'" : q{'end of input'}} $parser->YYExpect();
  my $expected = '';
  if (@expected) {
    $expected = (@expected >1) ? "Expected one of these terminals: @expected" 
                              : "Expected terminal: @expected"
  }

  my $tline = '';
  if (blessed($attr) && $attr->can('line')) {
    $tline = " (line number ".$attr->line.")" 
  }
  elsif (ref($attr) eq 'ARRAY') {
    $tline = " (line number ".$attr->[1].")";
  }
  else {
    # May be the parser object knows the line number ?
    my $lineno = $parser->line;
    $tline = " (line number $lineno)" if $lineno > 1;
  }

  local $" = ', ';
  warn << "ERRMSG";

Syntax error$stoken$tline. 
$expected
ERRMSG
};

################ end TailSupport #####################

sub _DBLoad {

  #Already loaded ?
  __PACKAGE__->can('_DBParse') and return;
  
  my($fname)=__FILE__;
  my(@drv);
  local $/ = "\n";
  if (open(DRV,"<$fname")) {
    local $_;
    while(<DRV>) {
       #/^\s*sub\s+_Parse\s*{\s*$/ .. /^\s*}\s*#\s*_Parse\s*$/ and do {
       /^my\s+\$lex;##!!##$/ .. /^\s*}\s*#\s*_Parse\s*$/ and do {
          s/^#DBG>//;
          push(@drv,$_);
      }
    }
    close(DRV);

    $drv[1]=~s/_P/_DBP/;
    eval join('',@drv);
  }
  else {
    # TODO: debugging for standalone modules isn't supported yet
    *Parse::Eyapp::Driver::_DBParse = \&_Parse;
  }
}

### Receives an  index for the parsing stack: -1 is the top
### Returns the symbol associated with the state $index
sub YYSymbol {
  my $self = shift;
  my $index = shift;
  
  return $self->{STACK}[$index][2];
}

# # YYSymbolStack(0,-k) string with symbols from 0 to last-k
# # YYSymbolStack(-k-2,-k) string with symbols from last-k-2 to last-k
# # YYSymbolStack(-k-2,-k, filter) string with symbols from last-k-2 to last-k that match with filter
# # YYSymbolStack('SYMBOL',-k, filter) string with symbols from the last occurrence of SYMBOL to last-k
# #                                    where filter can be code, regexp or string
# sub YYSymbolStack {
#   my $self = shift;
#   my ($a, $b, $filter) = @_;
#   
#   # $b must be negative
#   croak "Error: Second index in YYSymbolStack must be negative\n" unless $b < 0;
# 
#   my $stack = $self->{STACK};
#   my $bottom = -@{$stack};
#   unless (looks_like_number($a)) {
#     # $a is a string: search from the top to the bottom for $a. Return empty list if not found
#     # $b must be a negative number
#     # $b must be a negative number
#     my $p = $b;
#     while ($p >= $bottom) {
#       last if (defined($stack->[$p][2]) && ($stack->[$p][2] eq $a));
#       $p--;
#     }
#     return () if $p < $bottom;
#     $a = $p;
#   }
#   # If positive, $a is an offset from the bottom of the stack 
#   $a = $bottom+$a if $a >= 0;
#   
#   my @a = map { $self->YYSymbol($_) or '' } $a..$b;
#    
#   return @a                          unless defined $filter;          # no filter
#   return (grep { $filter->{$_} } @a) if reftype($filter) && (reftype($filter) eq 'CODE');   # sub
#   return (grep  /$filter/, @a)       if reftype($filter) && (reftype($filter) eq 'SCALAR'); # regexp
#   return (grep { $_ eq $filter } @a);                                  # string
# }

#Note that for loading debugging version of the driver,
#this file will be parsed from 'sub _Parse' up to '}#_Parse' inclusive.
#So, DO NOT remove comment at end of sub !!!
my $lex;##!!##
sub _Parse {
    my($self)=shift;

  #my $lex = $self->{LEX};

  my($rules,$states,$error)
     = @$self{ 'RULES', 'STATES', 'ERROR' };
  my($errstatus,$nberror,$token,$value,$stack,$check,$dotpos)
     = @$self{ 'ERRST', 'NBERR', 'TOKEN', 'VALUE', 'STACK', 'CHECK', 'DOTPOS' };

  my %conflictiveStates = %{$self->{STATECONFLICT}};
#DBG> my($debug)=$$self{DEBUG};
#DBG> my($dbgerror)=0;

#DBG> my($ShowCurToken) = sub {
#DBG>   my($tok)='>';
#DBG>   for (split('',$$token)) {
#DBG>     $tok.=    (ord($_) < 32 or ord($_) > 126)
#DBG>         ? sprintf('<%02X>',ord($_))
#DBG>         : $_;
#DBG>   }
#DBG>   $tok.='<';
#DBG> };

  $$errstatus=0;
  $$nberror=0;
  ($$token,$$value)=(undef,undef);
  @$stack=( [ 0, undef, ] );
#DBG>   push(@{$stack->[-1]}, undef);
  #@$stack=( [ 0, undef, undef ] );
  $$check='';

    while(1) {
        my($actions,$act,$stateno);

        $self->{POS} = pos(${$self->input()});
        $stateno=$$stack[-1][0];
        if (exists($conflictiveStates{$stateno})) {
          #warn "Conflictive state $stateno managed by conflict handler '$conflictiveStates{$stateno}{name}'\n" 
          for my $h (@{$conflictiveStates{$stateno}}) {
            $self->{CURRENT_LHS} = $h->{name};
            $h->{codeh}($self);
          }
        }

        # check if the state is a conflictive one,
        # if so, execute its conflict handlers
        $actions=$$states[$stateno];

#DBG> print STDERR ('-' x 40),"\n";
#DBG>   $debug & 0x2
#DBG> and print STDERR "In state $stateno:\n";
#DBG>   $debug & 0x08
#DBG> and print STDERR "Stack: ".
#DBG>          join('->',map { defined($$_[2])? "'$$_[2]'->".$$_[0] : $$_[0] } @$stack).
#DBG>          "\n";


        if  (exists($$actions{ACTIONS})) {

        defined($$token)
            or  do {
        ($$token,$$value)=$self->{LEX}->($self); # original line
        #($$token,$$value)=$self->$lex;   # to make it a method call
        #($$token,$$value) = $self->{LEX}->($self); # sensitive to the lexer changes
#DBG>       $debug & 0x01
#DBG>     and do { 
#DBG>       print STDERR "Need token. Got ".&$ShowCurToken."\n";
#DBG>     };
      };

            $act=   exists($$actions{ACTIONS}{$$token})
                    ?   $$actions{ACTIONS}{$$token}
                    :   exists($$actions{DEFAULT})
                        ?   $$actions{DEFAULT}
                        :   undef;
        }
        else {
            $act=$$actions{DEFAULT};
#DBG>     $debug & 0x01
#DBG>   and print STDERR "Don't need token.\n";
        }

            defined($act)
        and do {

                $act > 0
            and do {        #shift

#DBG>       $debug & 0x04
#DBG>     and print STDERR "Shift and go to state $act.\n";

          $$errstatus
        and do {
          --$$errstatus;

#DBG>         $debug & 0x10
#DBG>       and $dbgerror
#DBG>       and $$errstatus == 0
#DBG>       and do {
#DBG>         print STDERR "**End of Error recovery.\n";
#DBG>         $dbgerror=0;
#DBG>       };
        };


        push(@$stack,[ $act, $$value ]);
#DBG>   push(@{$stack->[-1]},$$token);

          defined($$token) and ($$token ne '') #Don't eat the eof
              and $$token=$$value=undef;
                next;
            };

            #reduce
            my($lhs,$len,$code,@sempar,$semval);
            ($lhs,$len,$code)=@{$$rules[-$act]};

#DBG>     $debug & 0x04
#DBG>   and $act
#DBG>   #and  print STDERR "Reduce using rule ".-$act." ($lhs,$len): "; # old Parse::Yapp line
#DBG>   and do { my @rhs = @{$self->{GRAMMAR}->[-$act]->[2]};
#DBG>            @rhs = ( '/* empty */' ) unless @rhs;
#DBG>            my $rhs = "@rhs";
#DBG>            $rhs = substr($rhs, 0, 30).'...' if length($rhs) > 30; # chomp if too large
#DBG>            print STDERR "Reduce using rule ".-$act." ($lhs --> $rhs): "; 
#DBG>          };

                $act
            or  $self->YYAccept();

            $$dotpos=$len;

                unpack('A1',$lhs) eq '@'    #In line rule
            and do {
                    $lhs =~ /^\@[0-9]+\-([0-9]+)$/
                or  die "In line rule name '$lhs' ill formed: ".
                        "report it as a BUG.\n";
                $$dotpos = $1;
            };

            @sempar =       $$dotpos
                        ?   map { $$_[1] } @$stack[ -$$dotpos .. -1 ]
                        :   ();

            $self->{CURRENT_LHS} = $lhs;
            $self->{CURRENT_RULE} = -$act; # count the super-rule?
            $semval = $code ? $self->$code( @sempar )
                            : @sempar ? $sempar[0] : undef;

            splice(@$stack,-$len,$len);

                $$check eq 'ACCEPT'
            and do {

#DBG>     $debug & 0x04
#DBG>   and print STDERR "Accept.\n";

        return($semval);
      };

                $$check eq 'ABORT'
            and do {

#DBG>     $debug & 0x04
#DBG>   and print STDERR "Abort.\n";

        return(undef);

      };

#DBG>     $debug & 0x04
#DBG>   and print STDERR "Back to state $$stack[-1][0], then ";

                $$check eq 'ERROR'
            or  do {
#DBG>       $debug & 0x04
#DBG>     and print STDERR 
#DBG>           "go to state $$states[$$stack[-1][0]]{GOTOS}{$lhs}.\n";

#DBG>       $debug & 0x10
#DBG>     and $dbgerror
#DBG>     and $$errstatus == 0
#DBG>     and do {
#DBG>       print STDERR "**End of Error recovery.\n";
#DBG>       $dbgerror=0;
#DBG>     };

          push(@$stack,
                     [ $$states[$$stack[-1][0]]{GOTOS}{$lhs}, $semval, ]);
                     #[ $$states[$$stack[-1][0]]{GOTOS}{$lhs}, $semval, $lhs ]);
#DBG>     push(@{$stack->[-1]},$lhs);
                $$check='';
                $self->{CURRENT_LHS} = undef;
                next;
            };

#DBG>     $debug & 0x04
#DBG>   and print STDERR "Forced Error recovery.\n";

            $$check='';

        };

        #Error
            $$errstatus
        or   do {

            $$errstatus = 1;
            &$error($self);
                $$errstatus # if 0, then YYErrok has been called
            or  next;       # so continue parsing

#DBG>     $debug & 0x10
#DBG>   and do {
#DBG>     print STDERR "**Entering Error recovery.\n";
#DBG>     { 
#DBG>       local $" = ", "; 
#DBG>       my @expect = map { ">$_<" } $self->YYExpect();
#DBG>       print STDERR "Expecting one of: @expect\n";
#DBG>     };
#DBG>     ++$dbgerror;
#DBG>   };

            ++$$nberror;

        };

      $$errstatus == 3  #The next token is not valid: discard it
    and do {
        $$token eq '' # End of input: no hope
      and do {
#DBG>       $debug & 0x10
#DBG>     and print STDERR "**At eof: aborting.\n";
        return(undef);
      };

#DBG>     $debug & 0x10
#DBG>   and print STDERR "**Discard invalid token ".&$ShowCurToken.".\n";

      $$token=$$value=undef;
    };

        $$errstatus=3;

    while(    @$stack
        and (   not exists($$states[$$stack[-1][0]]{ACTIONS})
              or  not exists($$states[$$stack[-1][0]]{ACTIONS}{error})
          or  $$states[$$stack[-1][0]]{ACTIONS}{error} <= 0)) {

#DBG>     $debug & 0x10
#DBG>   and print STDERR "**Pop state $$stack[-1][0].\n";

      pop(@$stack);
    }

      @$stack
    or  do {

#DBG>     $debug & 0x10
#DBG>   and print STDERR "**No state left on stack: aborting.\n";

      return(undef);
    };

    #shift the error token

#DBG>     $debug & 0x10
#DBG>   and print STDERR "**Shift \$error token and go to state ".
#DBG>            $$states[$$stack[-1][0]]{ACTIONS}{error}.
#DBG>            ".\n";

    push(@$stack, [ $$states[$$stack[-1][0]]{ACTIONS}{error}, undef, 'error' ]);

    }

    #never reached
  croak("Error in driver logic. Please, report it as a BUG");

}#_Parse
#DO NOT remove comment

*Parse::Eyapp::Driver::lexer = \&Parse::Eyapp::Driver::YYLexer;
sub YYLexer {
  my $self = shift;

  if (ref $self) { # instance method
    # The class attribute isn't changed, only the instance
    $self->{LEX} = shift if @_;

    return $self->static_attribute('LEX', @_,) unless defined($self->{LEX}); # class/static method 
    return $self->{LEX};
  }
  else {
    return $self->static_attribute('LEX', @_,);
  }
}


1;


MODULE_Parse_Eyapp_Driver
    }; # Unless Parse::Eyapp::Driver was loaded
  } ########### End of BEGIN { load /System/Library/Perl/Extras/5.18/Parse/Eyapp/Driver.pm }

  # Loading Parse::Eyapp::Node
  BEGIN {
    unless (Parse::Eyapp::Node->can('m')) {
      eval << 'MODULE_Parse_Eyapp_Node'
# (c) Parse::Eyapp Copyright 2006-2008 Casiano Rodriguez-Leon, all rights reserved.
package Parse::Eyapp::Node;
use strict;
use Carp;
no warnings 'recursion';use List::Util qw(first);
use Data::Dumper;

our $FILENAME=__FILE__;

sub firstval(&@) {
  my $handler = shift;
  
  return (grep { $handler->($_) } @_)[0]
}

sub lastval(&@) {
  my $handler = shift;
  
  return (grep { $handler->($_) } @_)[-1]
}

####################################################################
# Usage      : 
# line: %name PROG
#        exp <%name EXP + ';'>
#                 { @{$lhs->{t}} = map { $_->{t}} ($lhs->child(0)->children()); }
# ;
# Returns    : The array of children of the node. When the tree is a
#              translation scheme the CODE references are also included
# Parameters : the node (method)
# See Also   : Children

sub children {
  my $self = CORE::shift;
  
  return () unless UNIVERSAL::can($self, 'children');
  @{$self->{children}} = @_ if @_;
  @{$self->{children}}
}

####################################################################
# Usage      :  line: %name PROG
#                        (exp) <%name EXP + ';'>
#                          { @{$lhs->{t}} = map { $_->{t}} ($_[1]->Children()); }
#
# Returns    : The true children of the node, excluding CODE CHILDREN
# Parameters : The Node object

sub Children {
  my $self = CORE::shift;
  
  return () unless UNIVERSAL::can($self, 'children');

  @{$self->{children}} = @_ if @_;
  grep { !UNIVERSAL::isa($_, 'CODE') } @{$self->{children}}
}

####################################################################
# Returns    : Last non CODE child
# Parameters : the node object

sub Last_child {
  my $self = CORE::shift;

  return unless UNIVERSAL::can($self, 'children') and @{$self->{children}};
  my $i = -1;
  $i-- while defined($self->{children}->[$i]) and UNIVERSAL::isa($self->{children}->[$i], 'CODE');
  return  $self->{children}->[$i];
}

sub last_child {
  my $self = CORE::shift;

  return unless UNIVERSAL::can($self, 'children') and @{$self->{children}};
  ${$self->{children}}[-1];
}

####################################################################
# Usage      :  $node->child($i)
#  my $transform = Parse::Eyapp::Treeregexp->new( STRING => q{
#     commutative_add: PLUS($x, ., $y, .)
#       => { my $t = $x; $_[0]->child(0, $y); $_[0]->child(2, $t)}
#  }
# Purpose    : Setter-getter to modify a specific child of a node
# Returns    : Child with index $i. Returns undef if the child does not exists
# Parameters : Method: the node and the index of the child. The new value is used 
#              as a setter.
# Throws     : Croaks if the index parameter is not provided
sub child {
  my ($self, $index, $value) = @_;
  
  #croak "$self is not a Parse::Eyapp::Node" unless $self->isa('Parse::Eyapp::Node');
  return undef unless  UNIVERSAL::can($self, 'child');
  croak "Index not provided" unless defined($index);
  $self->{children}[$index] = $value if defined($value);
  $self->{children}[$index];
}

sub descendant {
  my $self = shift;
  my $coord = shift;

  my @pos = split /\./, $coord;
  my $t = $self;
  my $x = shift(@pos); # discard the first empty dot
  for (@pos) {
      croak "Error computing descendant: $_ is not a number\n" 
    unless m{\d+} and $_ < $t->children;
    $t = $t->child($_);
  }
  return $t;
}

####################################################################
# Usage      : $node->s(@transformationlist);
# Example    : The following example simplifies arithmetic expressions
# using method "s":
# > cat Timeszero.trg
# /* Operator "and" has higher priority than comma "," */
# whatever_times_zero: TIMES(@b, NUM($x) and { $x->{attr} == 0 }) => { $_[0] = $NUM }
#
# > treereg Timeszero
# > cat arrays.pl
#  !/usr/bin/perl -w
#  use strict;
#  use Rule6;
#  use Parse::Eyapp::Treeregexp;
#  use Timeszero;
#
#  my $parser = new Rule6();
#  my $t = $parser->Run;
#  $t->s(@Timeszero::all);
#
#
# Returns    : Nothing
# Parameters : The object (is a method) and the list of transformations to apply.
#              The list may be a list of Parse::Eyapp:YATW objects and/or CODE
#              references
# Throws     : No exceptions
# Comments   : The set of transformations is repeatedly applied to the node
#              until there are no changes.
#              The function may hang if the set of transformations
#              matches forever.
# See Also   : The "s" method for Parse::Eyapp::YATW objects 
#              (i.e. transformation objects)

sub s {
  my @patterns = @_[1..$#_];

  # Make them Parse::Eyapp:YATW objects if they are CODE references
  @patterns = map { ref($_) eq 'CODE'? 
                      Parse::Eyapp::YATW->new(
                        PATTERN => $_,
                        #PATTERN_ARGS => [],
                      )
                      :
                      $_
                  } 
                  @patterns;
  my $changes; 
  do { 
    $changes = 0;
    foreach (@patterns) {
      $_->{CHANGES} = 0;
      $_->s($_[0]);
      $changes += $_->{CHANGES};
    }
  } while ($changes);
}


####################################################################
# Usage      : ????
# Purpose    : bud = Bottom Up Decoration: Decorates the tree with flowers :-)
#              The purpose is to decorate the AST with attributes during
#              the context-dependent analysis, mainly type-checking.
# Returns    : ????
# Parameters : The transformations.
# Throws     : no exceptions
# Comments   : The tree is traversed bottom-up. The set of
#              transformations is applied to each node in the order
#              supplied by the user. As soon as one succeeds
#              no more transformations are applied.
# See Also   : n/a
# To Do      : Avoid closure. Save @patterns inside the object
{
  my @patterns;

  sub bud {
    @patterns = @_[1..$#_];

    @patterns = map { ref($_) eq 'CODE'? 
                        Parse::Eyapp::YATW->new(
                          PATTERN => $_,
                          #PATTERN_ARGS => [],
                        )
                        :
                        $_
                    } 
                    @patterns;
    _bud($_[0], undef, undef);
  }

  sub _bud {
    my $node = $_[0];
    my $index = $_[2];

      # Is an odd leaf. Not actually a Parse::Eyapp::Node. Decorate it and leave
      if (!ref($node) or !UNIVERSAL::can($node, "children"))  {
        for my $p (@patterns) {
          return if $p->pattern->(
            $_[0],  # Node being visited  
            $_[1],  # Father of this node
            $index, # Index of this node in @Father->children
            $p,  # The YATW pattern object   
          );
        }
      };

      # Recursively decorate subtrees
      my $i = 0;
      for (@{$node->{children}}) {
        $_->_bud($_, $_[0], $i);
        $i++;
      }

      # Decorate the node
      #Change YATW object to be the  first argument?
      for my $p (@patterns) {
        return if $p->pattern->($_[0], $_[1], $index, $p); 
      }
  }
} # closure for @patterns

####################################################################
# Usage      : 
# @t = Parse::Eyapp::Node->new( q{TIMES(NUM(TERMINAL), NUM(TERMINAL))}, 
#      sub { 
#        our ($TIMES, @NUM, @TERMINAL);
#        $TIMES->{type}       = "binary operation"; 
#        $NUM[0]->{type}      = "int"; 
#        $NUM[1]->{type}      = "float"; 
#        $TERMINAL[1]->{attr} = 3.5; 
#      },
#    );
# Purpose    : Multi-Constructor
# Returns    : Array of pointers to the objects created
#              in scalar context a pointer to the first node
# Parameters : The class plus the string description and attribute handler

{

my %cache;

  sub m_bless {

    my $key = join "",@_;
    my $class = shift;
    return $cache{$key} if exists $cache{$key};

    my $b = bless { children => \@_}, $class;
    $cache{$key} = $b;

    return $b;
  }
}

sub _bless {
  my $class = shift;

  my $b = bless { children => \@_ }, $class;
  return $b;
}

sub hexpand {
  my $class = CORE::shift;

  my $handler = CORE::pop if ref($_[-1]) eq 'CODE';
  my $n = m_bless(@_);

  my $newnodeclass = CORE::shift;

  no strict 'refs';
  push @{$newnodeclass."::ISA"}, 'Parse::Eyapp::Node' unless $newnodeclass->isa('Parse::Eyapp::Node');

  if (defined($handler) and UNIVERSAL::isa($handler, "CODE")) {
    $handler->($n);
  }

  $n;
}

sub hnew {
  my $blesser = \&m_bless;

  return _new($blesser, @_);
}

# Regexp for a full Perl identifier
sub _new {
  my $blesser = CORE::shift;
  my $class = CORE::shift;
  local $_ = CORE::shift; # string: tree description
  my $handler = CORE::shift if ref($_[0]) eq 'CODE';


  my %classes;
  my $b;
  #TODO: Shall I receive a prefix?

  my (@stack, @index, @results, %results, @place, $open);
  #skip white spaces
  s{\A\s+}{};
  while ($_) {
    # If is a leaf is followed by parenthesis or comma or an ID
    s{\A([A-Za-z_][A-Za-z0-9_:]*)\s*([),])} 
     {$1()$2} # ... then add an empty pair of parenthesis
      and do { 
        next; 
       };

    # If is a leaf is followed by an ID
    s{\A([A-Za-z_][A-Za-z0-9_:]*)\s+([A-Za-z_])} 
     {$1()$2} # ... then add an empty pair of parenthesis
      and do { 
        next; 
       };

    # If is a leaf at the end
    s{\A([A-Za-z_][A-Za-z0-9_:]*)\s*$} 
     {$1()} # ... then add an empty pair of parenthesis
      and do { 
        $classes{$1} = 1;
        next; 
       };

    # Is an identifier
    s{\A([A-Za-z_][A-Za-z0-9_:]*)}{} 
      and do { 
        $classes{$1} = 1;
        CORE::push @stack, $1; 
        next; 
      };

    # Open parenthesis: mark the position for when parenthesis closes
    s{\A[(]}{} 
      and do { 
        my $pos = scalar(@stack);
        CORE::push @index, $pos; 
        $place[$pos] = $open++;

        # Warning! I don't know what I am doing
        next;
      };

    # Skip commas
    s{\A,}{} and next; 

    # Closing parenthesis: time to build a node
    s{\A[)]}{} and do { 
        croak "Syntax error! Closing parenthesis has no left partner!" unless @index;
        my $begin = pop @index; # check if empty!
        my @children = splice(@stack, $begin);
        my $class = pop @stack;
        croak "Syntax error! Any couple of parenthesis must be preceded by an identifier"
          unless (defined($class) and $class =~ m{^[a-zA-Z_][\w:]*$});

        $b = $blesser->($class, @children);

        CORE::push @stack, $b;
        $results[$place[$begin]] = $b;
        CORE::push @{$results{$class}}, $b;
        next; 
    }; 

    last unless $_;

    #skip white spaces
    croak "Error building Parse::Eyapp::Node tree at '$_'." unless s{\A\s+}{};
  } # while
  croak "Syntax error! Open parenthesis has no right partner!" if @index;
  { 
    no strict 'refs';
    for (keys(%classes)) {
      push @{$_."::ISA"}, 'Parse::Eyapp::Node' unless $_->isa('Parse::Eyapp::Node');
    }
  }
  if (defined($handler) and UNIVERSAL::isa($handler, "CODE")) {
    $handler->(@results);
  }
  return wantarray? @results : $b;
}

sub new {
  my $blesser = \&_bless;

  _new($blesser, @_);
}

## Used by _subtree_list
#sub compute_hierarchy {
#  my @results = @{shift()};
#
#  # Compute the hierarchy
#  my $b;
#  my @r = @results;
#  while (@results) {
#    $b = pop @results;
#    my $d = $b->{depth};
#    my $f = lastval { $_->{depth} < $d} @results;
#    
#    $b->{father} = $f;
#    $b->{children} = [];
#    unshift @{$f->{children}}, $b;
#  }
#  $_->{father} = undef for @results;
#  bless $_, "Parse::Eyapp::Node::Match" for @r;
#  return  @r;
#}

# Matches

sub m {
  my $self = shift;
  my @patterns = @_ or croak "Expected a pattern!";
  croak "Error in method m of Parse::Eyapp::Node. Expected Parse::Eyapp:YATW patterns"
    unless $a = first { !UNIVERSAL::isa($_, "Parse::Eyapp:YATW") } @_;

  # array context: return all matches
  local $a = 0;
  my %index = map { ("$_", $a++) } @patterns;
  my @stack = (
    Parse::Eyapp::Node::Match->new( 
       node => $self, 
       depth => 0,  
       dewey => "", 
       patterns =>[] 
    ) 
  );
  my @results;
  do {
    my $mn = CORE::shift(@stack);
    my %n = %$mn;

    # See what patterns do match the current $node
    for my $pattern (@patterns) {
      push @{$mn->{patterns}}, $index{$pattern} if $pattern->{PATTERN}($n{node});
    } 
    my $dewey = $n{dewey};
    if (@{$mn->{patterns}}) {
      $mn->{family} = \@patterns;

      # Is at this time that I have to compute the father
      my $f = lastval { $dewey =~ m{^$_->{dewey}}} @results;
      $mn->{father} = $f;
      # ... and children
      push @{$f->{children}}, $mn if defined($f);
      CORE::push @results, $mn;
    }
    my $childdepth = $n{depth}+1;
    my $k = -1;
    CORE::unshift @stack, 
          map 
            { 
              $k++; 
              Parse::Eyapp::Node::Match->new(
                node => $_, 
                depth => $childdepth, 
                dewey => "$dewey.$k", 
                patterns => [] 
              ) 
            } $n{node}->children();
  } while (@stack);

  wantarray? @results : $results[0];
}

#sub _subtree_scalar {
#  # scalar context: return iterator
#  my $self = CORE::shift;
#  my @patterns = @_ or croak "Expected a pattern!";
#
#  # %index gives the index of $p in @patterns
#  local $a = 0;
#  my %index = map { ("$_", $a++) } @patterns;
#
#  my @stack = ();
#  my $mn = { node => $self, depth => 0, patterns =>[] };
#  my @results = ();
#
#  return sub {
#     do {
#       # See if current $node matches some patterns
#       my $d = $mn->{depth};
#       my $childdepth = $d+1;
#       # See what patterns do match the current $node
#       for my $pattern (@patterns) {
#         push @{$mn->{patterns}}, $index{$pattern} if $pattern->{PATTERN}($mn->{node});
#       } 
#
#       if (@{$mn->{patterns}}) { # matched
#         CORE::push @results, $mn;
#
#         # Compute the hierarchy
#         my $f = lastval { $_->{depth} < $d} @results;
#         $mn->{father} = $f;
#         $mn->{children} = [];
#         $mn->{family} = \@patterns;
#         unshift @{$f->{children}}, $mn if defined($f);
#         bless $mn, "Parse::Eyapp::Node::Match";
#
#         # push children in the stack
#         CORE::unshift @stack, 
#                   map { { node => $_, depth => $childdepth, patterns => [] } } 
#                                                       $mn->{node}->children();
#         $mn = CORE::shift(@stack);
#         return $results[-1];
#       }
#       # didn't match: push children in the stack
#       CORE::unshift @stack, 
#                  map { { node => $_, depth => $childdepth, patterns => [] } } 
#                                                      $mn->{node}->children();
#       $mn = CORE::shift(@stack);
#     } while ($mn); # May be the stack is empty now, but if $mn then there is a node to process
#     # reset iterator
#     my @stack = ();
#     my $mn = { node => $self, depth => 0, patterns =>[] };
#     return undef;
#   };
#}

# Factorize this!!!!!!!!!!!!!!
#sub m {
#  goto &_subtree_list if (wantarray()); 
#  goto &_subtree_scalar;
#}

####################################################################
# Usage      :   $BLOCK->delete($ASSIGN)
#                $BLOCK->delete(2)
# Purpose    : deletes the specified child of the node
# Returns    : The deleted child
# Parameters : The object plus the index or pointer to the child to be deleted
# Throws     : If the object can't do children or has no children
# See Also   : n/a

sub delete {
  my $self = CORE::shift; # The tree object
  my $child = CORE::shift; # index or pointer

  croak "Parse::Eyapp::Node::delete error, node:\n"
        .Parse::Eyapp::Node::str($self)."\ndoes not have children" 
    unless UNIVERSAL::can($self, 'children') and ($self->children()>0);
  if (ref($child)) {
    my $i = 0;
    for ($self->children()) {
      last if $_ == $child;
      $i++;
    }
    if ($i == $self->children()) {
      warn "Parse::Eyapp::Node::delete warning: node:\n".Parse::Eyapp::Node::str($self)
           ."\ndoes not have a child like:\n"
           .Parse::Eyapp::Node::str($child)
           ."\nThe node was not deleted!\n";
      return $child;
    }
    splice(@{$self->{children}}, $i, 1);
    return $child;
  }
  my $numchildren = $self->children();
  croak "Parse::Eyapp::Node::delete error: expected an index between 0 and ".
        ($numchildren-1).". Got $child" unless ($child =~ /\d+/ and $child < $numchildren);
  splice(@{$self->{children}}, $child, 1);
  return $child;
}

####################################################################
# Usage      : $BLOCK->shift
# Purpose    : deletes the first child of the node
# Returns    : The deleted child
# Parameters : The object 
# Throws     : If the object can't do children 
# See Also   : n/a

sub shift {
  my $self = CORE::shift; # The tree object

  croak "Parse::Eyapp::Node::shift error, node:\n"
       .Parse::Eyapp::Node->str($self)."\ndoes not have children" 
    unless UNIVERSAL::can($self, 'children');

  return CORE::shift(@{$self->{children}});
}

sub unshift {
  my $self = CORE::shift; # The tree object
  my $node = CORE::shift; # node to insert

  CORE::unshift @{$self->{children}}, $node;
}

sub push {
  my $self = CORE::shift; # The tree object
  #my $node = CORE::shift; # node to insert

  #CORE::push @{$self->{children}}, $node;
  CORE::push @{$self->{children}}, @_;
}

sub insert_before {
  my $self = CORE::shift; # The tree object
  my $child = CORE::shift; # index or pointer
  my $node = CORE::shift; # node to insert

  croak "Parse::Eyapp::Node::insert_before error, node:\n"
        .Parse::Eyapp::Node::str($self)."\ndoes not have children" 
    unless UNIVERSAL::can($self, 'children') and ($self->children()>0);

  if (ref($child)) {
    my $i = 0;
    for ($self->children()) {
      last if $_ == $child;
      $i++;
    }
    if ($i == $self->children()) {
      warn "Parse::Eyapp::Node::insert_before warning: node:\n"
           .Parse::Eyapp::Node::str($self)
           ."\ndoes not have a child like:\n"
           .Parse::Eyapp::Node::str($child)."\nThe node was not inserted!\n";
      return $child;
    }
    splice(@{$self->{children}}, $i, 0, $node);
    return $node;
  }
  my $numchildren = $self->children();
  croak "Parse::Eyapp::Node::insert_before error: expected an index between 0 and ".
        ($numchildren-1).". Got $child" unless ($child =~ /\d+/ and $child < $numchildren);
  splice(@{$self->{children}}, $child, 0, $node);
  return $child;
}

sub insert_after {
  my $self = CORE::shift; # The tree object
  my $child = CORE::shift; # index or pointer
  my $node = CORE::shift; # node to insert

  croak "Parse::Eyapp::Node::insert_after error, node:\n"
        .Parse::Eyapp::Node::str($self)."\ndoes not have children" 
    unless UNIVERSAL::can($self, 'children') and ($self->children()>0);

  if (ref($child)) {
    my $i = 0;
    for ($self->children()) {
      last if $_ == $child;
      $i++;
    }
    if ($i == $self->children()) {
      warn "Parse::Eyapp::Node::insert_after warning: node:\n"
           .Parse::Eyapp::Node::str($self).
           "\ndoes not have a child like:\n"
           .Parse::Eyapp::Node::str($child)."\nThe node was not inserted!\n";
      return $child;
    }
    splice(@{$self->{children}}, $i+1, 0, $node);
    return $node;
  }
  my $numchildren = $self->children();
  croak "Parse::Eyapp::Node::insert_after error: expected an index between 0 and ".
        ($numchildren-1).". Got $child" unless ($child =~ /\d+/ and $child < $numchildren);
  splice(@{$self->{children}}, $child+1, 0, $node);
  return $child;
}

{ # $match closure

  my $match;

  sub clean_tree {
    $match = pop;
    croak "clean tree: a node and code reference expected" unless (ref($match) eq 'CODE') and (@_ > 0);
    $_[0]->_clean_tree();
  }

  sub _clean_tree {
    my @children;
    
    for ($_[0]->children()) {
      next if (!defined($_) or $match->($_));
      
      $_->_clean_tree();
      CORE::push @children, $_;
    }
    $_[0]->{children} = \@children; # Bad code
  }
} # $match closure

####################################################################
# Usage      : $t->str 
# Returns    : Returns a string describing the Parse::Eyapp::Node as a term
#              i.e., s.t. like: 'PROGRAM(FUNCTION(RETURN(TERMINAL,VAR(TERMINAL))))'
our @PREFIXES = qw(Parse::Eyapp::Node::);
our $INDENT = 0; # -1 new 0 = compact, 1 = indent, 2 = indent and include Types in closing parenthesis
our $STRSEP = ',';
our $DELIMITER = '[';
our $FOOTNOTE_HEADER = "\n---------------------------\n";
our $FOOTNOTE_SEP = ")\n";
our $FOOTNOTE_LEFT = '^{';
our $FOOTNOTE_RIGHT = '}';
our $LINESEP = 4;
our $CLASS_HANDLER = sub { type($_[0]) }; # What to print to identify the node

my %match_del = (
  '[' => ']',
  '{' => '}',
  '(' => ')',
  '<' => '>'
);

my $pair;
my $footnotes = '';
my $footnote_label;

sub str {

  my @terms;

  # Consume arg only if called as a class method Parse::Eyap::Node->str($node1, $node2, ...)
  CORE::shift unless ref($_[0]);

  for (@_) {
    $footnote_label = 0;
    $footnotes = '';
    # Set delimiters for semantic values
    if (defined($DELIMITER) and exists($match_del{$DELIMITER})) {
      $pair = $match_del{$DELIMITER};
    }
    else {
      $DELIMITER = $pair = '';
    }
    CORE::push @terms,  _str($_).$footnotes;
  }
  return wantarray? @terms : $terms[0];
}  

sub _str {
  my $self = CORE::shift;          # root of the subtree
  my $indent = (CORE::shift or 0); # current depth in spaces " "

  my @children = Parse::Eyapp::Node::children($self);
  my @t;

  my $res;
  my $fn = $footnote_label;
  if ($INDENT >= 0 && UNIVERSAL::can($self, 'footnote')) {
    $res = $self->footnote; 
    $footnotes .= $FOOTNOTE_HEADER.$footnote_label++.$FOOTNOTE_SEP.$res if $res;
  }

  # recursively visit nodes
  for (@children) {
    CORE::push @t, Parse::Eyapp::Node::_str($_, $indent+2) if defined($_);
  }
  local $" = $STRSEP;
  my $class = $CLASS_HANDLER->($self);
  $class =~ s/^$_// for @PREFIXES; 
  my $information;
  $information = $self->info if ($INDENT >= 0 && UNIVERSAL::can($self, 'info'));
  $class .= $DELIMITER.$information.$pair if defined($information);
  if ($INDENT >= 0 &&  $res) {
   $class .= $FOOTNOTE_LEFT.$fn.$FOOTNOTE_RIGHT;
  }

  if ($INDENT > 0) {
    my $w = " "x$indent;
    $class = "\n$w$class";
    $class .= "(@t\n$w)" if @children;
    $class .= " # ".$CLASS_HANDLER->($self) if ($INDENT > 1) and ($class =~ tr/\n/\n/>$LINESEP);
  }
  else {
    $class .= "(@t)" if @children;
  }
  return $class;
}

sub _dot {
  my ($root, $number) = @_;

  my $type = $root->type();

  my $information;
  $information = $root->info if ($INDENT >= 0 && $root->can('info'));
  my $class = $CLASS_HANDLER->($root);
  $class = qq{$class<font color="red">$DELIMITER$information$pair</font>} if defined($information);

  my $dot = qq{  $number [label = <$class>];\n};

  my $k = 0;
  my @dots = map { $k++; $_->_dot("$number$k") }  $root->children;

  for($k = 1; $k <= $root->children; $k++) {;
    $dot .= qq{  $number -> $number$k;\n};
  }

  return $dot.join('',@dots);
}

sub dot {
  my $dot = $_[0]->_dot('0');
  return << "EOGRAPH";
digraph G {
ordering=out

$dot
}
EOGRAPH
}

sub fdot {
  my ($self, $file) = @_;

  if ($file) {
    $file .= '.dot' unless $file =~ /\.dot$/;
  }
  else {
    $file = $self->type().".dot";
  }
  open my $f, "> $file";
  print $f $self->dot();
  close($f);
}

BEGIN {
  my @dotFormats = qw{bmp canon cgimage cmap cmapx cmapx_np eps exr fig gd gd2 gif gv imap imap_np ismap jp2 jpe jpeg jpg pct pdf pict plain plain-ext png ps ps2 psd sgi svg svgz tga tif tiff tk vml vmlz vrml wbmp x11 xdot xlib};

  for my $format (@dotFormats) {
     
    no strict 'refs';
    *{'Parse::Eyapp::Node::'.$format} = sub { 
       my ($self, $file) = @_;
   
       $file = $self->type() unless defined($file);
   
       $self->fdot($file);
   
       $file =~ s/\.(dot|$format)$//;
       my $dotfile = "$file.dot";
       my $pngfile = "$file.$format";
       my $err = qx{dot -T$format $dotfile -o $pngfile 2>&1};
       return ($err, $?);
    }
  }
}

sub translation_scheme {
  my $self = CORE::shift; # root of the subtree
  my @children = $self->children();
  for (@children) {
    if (ref($_) eq 'CODE') {
      $_->($self, $self->Children);
    }
    elsif (defined($_)) {
      translation_scheme($_);
    }
  }
}

sub type {
 my $type = ref($_[0]);

 if ($type) {
   if (defined($_[1])) {
     $type = $_[1];
     Parse::Eyapp::Driver::BeANode($type);
     bless $_[0], $type;
   }
   return $type 
 }
 return 'Parse::Eyapp::Node::STRING';
}

{ # Tree "fuzzy" equality

####################################################################
# Usage      : $t1->equal($t2, n => sub { return $_[0] == $_[1] })
# Purpose    : Checks the equality between two AST
# Returns    : 1 if equal, 0 if not 'equal'
# Parameters : Two Parse::Eyapp:Node nodes and a hash of comparison handlers.
#              The keys of the hash are the attributes of the nodes. The value is
#              a comparator function. The comparator for key $k receives the attribute
#              for the nodes being visited and rmust return true if they are considered similar
# Throws     : exceptions if the parameters aren't Parse::Eyapp::Nodes

  my %handler;

  # True if the two trees look similar
  sub equal {
    croak "Parse::Eyapp::Node::equal error. Expected two syntax trees \n" unless (@_ > 1);

    %handler = splice(@_, 2);
    my $key = '';
    defined($key=firstval {!UNIVERSAL::isa($handler{$_},'CODE') } keys %handler) 
    and 
      croak "Parse::Eyapp::Node::equal error. Expected a CODE ref for attribute $key\n";
    goto &_equal;
  }

  sub _equal {
    my $tree1 = CORE::shift;
    my $tree2 = CORE::shift;

    # Same type
    return 0 unless ref($tree1) eq ref($tree2);

    # Check attributes via handlers
    for (keys %handler) {
      # Check for existence
      return 0 if (exists($tree1->{$_}) && !exists($tree2->{$_}));
      return 0 if (exists($tree2->{$_}) && !exists($tree1->{$_}));

      # Check for definition
      return 0 if (defined($tree1->{$_}) && !defined($tree2->{$_}));
      return 0 if (defined($tree2->{$_}) && !defined($tree1->{$_}));

      # Check for equality
      return 0 unless $handler{$_}->($tree1->{$_}, $tree2->{$_});
    }

    # Same number of children
    my @children1 = @{$tree1->{children}};
    my @children2 = @{$tree2->{children}};
    return 0 unless @children1 == @children2;

    # Children must be similar
    for (@children1) {
      my $ch2 = CORE::shift @children2;
      return 0 unless _equal($_, $ch2);
    }
    return 1;
  }
}

1;

package Parse::Eyapp::Node::Match;
our @ISA = qw(Parse::Eyapp::Node);

# A Parse::Eyapp::Node::Match object is a reference
# to a tree of Parse::Eyapp::Nodes that has been used
# in a tree matching regexp. You can think of them
# as the equivalent of $1 $2, ... in treeregexeps

# The depth of the Parse::Eyapp::Node being referenced

sub new {
  my $class = shift;

  my $matchnode = { @_ };
  $matchnode->{children} = [];
  bless $matchnode, $class;
}

sub depth {
  my $self = shift;

  return $self->{depth};
}

# The coordinates of the Parse::Eyapp::Node being referenced
sub coord {
  my $self = shift;

  return $self->{dewey};
}


# The Parse::Eyapp::Node being referenced
sub node {
  my $self = shift;

  return $self->{node};
}

# The Parse::Eyapp::Node:Match that references
# the nearest ancestor of $self->{node} that matched
sub father {
  my $self = shift;

  return $self->{father};
}
  
# The patterns that matched with $self->{node}
# Indexes
sub patterns {
  my $self = shift;

  @{$self->{patterns}} = @_ if @_;
  return @{$self->{patterns}};
}
  
# The original list of patterns that produced this match
sub family {
  my $self = shift;

  @{$self->{family}} = @_ if @_;
  return @{$self->{family}};
}
  
# The names of the patterns that matched
sub names {
  my $self = shift;

  my @indexes = $self->patterns;
  my @family = $self->family;

  return map { $_->{NAME} or "Unknown" } @family[@indexes];
}
  
sub info {
  my $self = shift;

  my $node = $self->node;
  my @names = $self->names;
  my $nodeinfo;
  if (UNIVERSAL::can($node, 'info')) {
    $nodeinfo = ":".$node->info;
  }
  else {
    $nodeinfo = "";
  }
  return "[".ref($self->node).":".$self->depth.":@names$nodeinfo]"
}

1;



MODULE_Parse_Eyapp_Node
    }; # Unless Parse::Eyapp::Node was loaded
  } ########### End of BEGIN { load /System/Library/Perl/Extras/5.18/Parse/Eyapp/Node.pm }

  # Loading Parse::Eyapp::YATW
  BEGIN {
    unless (Parse::Eyapp::YATW->can('m')) {
      eval << 'MODULE_Parse_Eyapp_YATW'
# (c) Parse::Eyapp Copyright 2006-2008 Casiano Rodriguez-Leon, all rights reserved.
package Parse::Eyapp::YATW;
use strict;
use warnings;
use Carp;
use Data::Dumper;
use List::Util qw(first);

sub firstval(&@) {
  my $handler = shift;
  
  return (grep { $handler->($_) } @_)[0]
}

sub lastval(&@) {
  my $handler = shift;
  
  return (grep { $handler->($_) } @_)[-1]
}

sub valid_keys {
  my %valid_args = @_;

  my @valid_args = keys(%valid_args); 
  local $" = ", "; 
  return "@valid_args" 
}

sub invalid_keys {
  my $valid_args = shift;
  my $args = shift;

  return (first { !exists($valid_args->{$_}) } keys(%$args));
}


our $VERSION = $Parse::Eyapp::Driver::VERSION;

our $FILENAME=__FILE__;

# TODO: Check args. Typical args:
# 'CHANGES' => 0,
# 'PATTERN' => sub { "DUMMY" },
# 'NAME' => 'fold',
# 'PATTERN_ARGS' => [],
# 'PENDING_TASKS' => {},
# 'NODE' => []

my %_new_yatw = (
  PATTERN => 'CODE',
  NAME => 'STRING',
);

my $validkeys = valid_keys(%_new_yatw); 

sub new {
  my $class = shift;
  my %args = @_;

  croak "Error. Expected a code reference when building a tree walker. " unless (ref($args{PATTERN}) eq 'CODE');
  if (defined($a = invalid_keys(\%_new_yatw, \%args))) {
    croak("Parse::Eyapp::YATW::new Error!: unknown argument $a. Valid arguments are: $validkeys")
  }


  # obsolete, I have to delete this
  #$args{PATTERN_ARGS} = [] unless (ref($args{PATTERN_ARGS}) eq 'ARRAY'); 

  # Internal fields

  # Tell us if the node has changed after the visit
  $args{CHANGES} = 0;
  
  # PENDING_TASKS is a queue storing the tasks waiting for a "safe time/node" to do them 
  # Usually that time occurs when visiting the father of the node who generated the job 
  # (when asap criteria is applied).
  # Keys are node references. Values are array references. Each entry defines:
  #  [ the task kind, the node where to do the job, and info related to the particular job ]
  # Example: @{$self->{PENDING_TASKS}{$father}}, ['insert_before', $node, ${$self->{NODE}}[0] ];
  $args{PENDING_TASKS} = {};

  # NODE is a stack storing the ancestor of the node being visited
  # Example: my $ancestor = ${$self->{NODE}}[$k]; when k=1 is the father, k=2 the grandfather, etc.
  # Example: CORE::unshift @{$self->{NODE}}, $_[0]; Finished the visit so take it out
  $args{NODE} = [];

  bless \%args, $class;
}

sub buildpatterns {
  my $class = shift;
  
  my @family;
  while (my ($n, $p) = splice(@_, 0,2)) {
    push @family, Parse::Eyapp::YATW->new(NAME => $n, PATTERN => $p);
  }
  return wantarray? @family : $family[0];
}

####################################################################
# Usage      : @r = $b{$_}->m($t)
#              See Simple4.eyp and m_yatw.pl in the examples directory
# Returns    : Returns an array of nodes matching the treeregexp
#              The set of nodes is a Parse::Eyapp::Node::Match tree 
#              showing the relation between the matches
# Parameters : The tree (and the object of course)
# depth is no longer used: eliminate
sub m {
  my $p = shift(); # pattern YATW object
  my $t = shift;   # tree
  my $pattern = $p->{PATTERN}; # CODE ref

  # References to the found nodes are stored in @stack
  my @stack = ( Parse::Eyapp::Node::Match->new(node=>$t, depth=>0, dewey => "") ); 
  my @results;
  do {
    my $n = CORE::shift(@stack);
    my %n = %$n;

    my $dewey = $n->{dewey};
    my $d = $n->{depth};
    if ($pattern->($n{node})) {
      $n->{family} = [ $p ];
      $n->{patterns} = [ 0 ];

      # Is at this time that I have to compute the father
      my $f = lastval { $dewey =~ m{^$_->{dewey}}} @results;
      $n->{father} = $f;
      # ... and children
      push @{$f->{children}}, $n if defined($f);
      push @results, $n;
    }
    my $k = 0;
    CORE::unshift @stack, 
       map { 
              local $a;
              $a = Parse::Eyapp::Node::Match->new(node=>$_, depth=>$d+1, dewey=>"$dewey.$k" );
              $k++;
              $a;
           } $n{node}->children();
  } while (@stack);

  return wantarray? @results : $results[0];
}

######################### getter-setter for YATW objects ###########################

sub pattern {
  my $self = shift;
  $self->{PATTERN} = shift if (@_);
  return $self->{PATTERN};
}

sub name {
  my $self = shift;
  $self->{NAME} = shift if (@_);
  return $self->{NAME};
}

#sub pattern_args {
#  my $self = shift;
#
#  $self->{PATTERN_ARGS} = @_ if @_;
#  return @{$self->{PATTERN_ARGS}};
#}

########################## PENDING TASKS management ################################

# Purpose    : Deletes the node that matched from the list of children of its father. 
sub delete {
  my $self = shift;

  bless $self->{NODE}[0], 'Parse::Eyapp::Node::DELETE';
}
  
sub make_delete_effective {
  my $self = shift;
  my $node = shift;

  my $i = -1+$node->children;
  while ($i >= 0) {
    if (UNIVERSAL::isa($node->child($i), 'Parse::Eyapp::Node::DELETE')) {
      $self->{CHANGES}++ if defined(splice(@{$node->{children}}, $i, 1));
    }
    $i--;
  }
}

####################################################################
# Usage      :    my $b = Parse::Eyapp::Node->new( 'NUM(TERMINAL)', sub { $_[1]->{attr} = 4 });
#                 $yatw_pattern->unshift($b); 
# Parameters : YATW object, node to insert, 
#              ancestor offset: 0 = root of the tree that matched, 1 = father, 2 = granfather, etc.

sub unshift {
  my ($self, $node, $k) = @_;
  $k = 1 unless defined($k); # father by default

  my $ancestor = ${$self->{NODE}}[$k];
  croak "unshift: does not exist ancestor $k of node ".Dumper(${$self->{NODE}}[0]) unless defined($ancestor);

  # Stringification of $ancestor. Hope it works
                                            # operation, node to insert, 
  push @{$self->{PENDING_TASKS}{$ancestor}}, ['unshift', $node ];
}

sub insert_before {
  my ($self, $node) = @_;

  my $father = ${$self->{NODE}}[1];
  croak "insert_before: does not exist father of node ".Dumper(${$self->{NODE}}[0]) unless defined($father);

                                           # operation, node to insert, before this node 
  push @{$self->{PENDING_TASKS}{$father}}, ['insert_before', $node, ${$self->{NODE}}[0] ];
}

sub _delayed_insert_before {
  my ($father, $node, $before) = @_;

  my $i = 0;
  for ($father->children()) {
    last if ($_ == $before);
    $i++;
  }
  splice @{$father->{children}}, $i, 0, $node;
}

sub do_pending_tasks {
  my $self = shift;
  my $node = shift;

  my $mytasks = $self->{PENDING_TASKS}{$node};
  while ($mytasks and (my $job = shift @{$mytasks})) {
    my @args = @$job;
    my $task = shift @args;

    # change this for a jump table
    if ($task eq 'unshift') {
      CORE::unshift(@{$node->{children}}, @args);
      $self->{CHANGES}++;
    }
    elsif ($task eq 'insert_before') {
      _delayed_insert_before($node, @args);
      $self->{CHANGES}++;
    }
  }
}

####################################################################
# Parameters : pattern, node, father of the node, index of the child in the children array
# YATW object. Probably too many 
sub s {
  my $self = shift;
  my $node = $_[0] or croak("Error. Method __PACKAGE__::s requires a node");
  CORE::unshift @{$self->{NODE}}, $_[0];
  # father is $_[1]
  my $index = $_[2];

  # If is not a reference or can't children then simply check the matching and leave
  if (!ref($node) or !UNIVERSAL::can($node, "children"))  {
                                         
    $self->{CHANGES}++ if $self->pattern->(
      $_[0],  # Node being visited  
      $_[1],  # Father of this node
      $index, # Index of this node in @Father->children
      $self,  # The YATW pattern object   
    );
    return;
  };
  
  # Else, is not a leaf and is a regular Parse::Eyapp::Node
  # Recursively transform subtrees
  my $i = 0;
  for (@{$node->{children}}) {
    $self->s($_, $_[0], $i);
    $i++;
  }
  
  my $number_of_changes = $self->{CHANGES};
  # Now is safe to delete children nodes that are no longer needed
  $self->make_delete_effective($node);

  # Safely do pending jobs for this node
  $self->do_pending_tasks($node);

  #node , father, childindex, and ... 
  #Change YATW object to be the  first argument?
  if ($self->pattern->($_[0], $_[1], $index, $self)) {
    $self->{CHANGES}++;
  }
  shift @{$self->{NODE}};
}

1;


MODULE_Parse_Eyapp_YATW
    }; # Unless Parse::Eyapp::YATW was loaded
  } ########### End of BEGIN { load /System/Library/Perl/Extras/5.18/Parse/Eyapp/YATW.pm }



sub unexpendedInput { defined($_) ? substr($_, (defined(pos $_) ? pos $_ : 0)) : '' }



# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      m{\G(\s+)}gc and $self->tokenline($1 =~ tr{\n}{});

      m{\G(\(|\^|\,|\/|\&|\~|\[|\:|\;|\||\)|\>|\<|\{|\!|\?|\+|\%|\]|\=|\*|\-|\.|\})}gc and return ($1, $1);

      /\G(SIZEOF)/gc and return ($1, $1);
      /\G(CONSTANT)/gc and return ($1, $1);
      /\G(STRING_LITERAL)/gc and return ($1, $1);
      /\G(IDENTIFIER)/gc and return ($1, $1);
      /\G(PTR_OP)/gc and return ($1, $1);
      /\G(INC_OP)/gc and return ($1, $1);
      /\G(GE_OP)/gc and return ($1, $1);
      /\G(LE_OP)/gc and return ($1, $1);
      /\G(LEFT_OP)/gc and return ($1, $1);
      /\G(NE_OP)/gc and return ($1, $1);
      /\G(EQ_OP)/gc and return ($1, $1);
      /\G(RIGHT_OP)/gc and return ($1, $1);
      /\G(DEC_OP)/gc and return ($1, $1);
      /\G(MOD_ASSIGN)/gc and return ($1, $1);
      /\G(DIV_ASSIGN)/gc and return ($1, $1);
      /\G(OR_OP)/gc and return ($1, $1);
      /\G(AND_OP)/gc and return ($1, $1);
      /\G(MUL_ASSIGN)/gc and return ($1, $1);
      /\G(ADD_ASSIGN)/gc and return ($1, $1);
      /\G(RIGHT_ASSIGN)/gc and return ($1, $1);
      /\G(SUB_ASSIGN)/gc and return ($1, $1);
      /\G(AND_ASSIGN)/gc and return ($1, $1);
      /\G(LEFT_ASSIGN)/gc and return ($1, $1);
      /\G(XOR_ASSIGN)/gc and return ($1, $1);
      /\G(TYPE_NAME)/gc and return ($1, $1);
      /\G(OR_ASSIGN)/gc and return ($1, $1);
      /\G(EXTERN)/gc and return ($1, $1);
      /\G(AUTO)/gc and return ($1, $1);
      /\G(REGISTER)/gc and return ($1, $1);
      /\G(STATIC)/gc and return ($1, $1);
      /\G(TYPEDEF)/gc and return ($1, $1);
      /\G(SIGNED)/gc and return ($1, $1);
      /\G(FLOAT)/gc and return ($1, $1);
      /\G(DOUBLE)/gc and return ($1, $1);
      /\G(SHORT)/gc and return ($1, $1);
      /\G(VOID)/gc and return ($1, $1);
      /\G(VOLATILE)/gc and return ($1, $1);
      /\G(INT)/gc and return ($1, $1);
      /\G(CHAR)/gc and return ($1, $1);
      /\G(UNSIGNED)/gc and return ($1, $1);
      /\G(LONG)/gc and return ($1, $1);
      /\G(CONST)/gc and return ($1, $1);
      /\G(ELLIPSIS)/gc and return ($1, $1);
      /\G(ENUM)/gc and return ($1, $1);
      /\G(UNION)/gc and return ($1, $1);
      /\G(STRUCT)/gc and return ($1, $1);
      /\G(FOR)/gc and return ($1, $1);
      /\G(RETURN)/gc and return ($1, $1);
      /\G(GOTO)/gc and return ($1, $1);
      /\G(DO)/gc and return ($1, $1);
      /\G(IF)/gc and return ($1, $1);
      /\G(WHILE)/gc and return ($1, $1);
      /\G(BREAK)/gc and return ($1, $1);
      /\G(DEFAULT)/gc and return ($1, $1);
      /\G(ELSE)/gc and return ($1, $1);
      /\G(SWITCH)/gc and return ($1, $1);
      /\G(CASE)/gc and return ($1, $1);
      /\G(CONTINUE)/gc and return ($1, $1);


      return ('', undef) if ($_ eq '') || (defined(pos($_)) && (pos($_) >= length($_)));
      /\G\s*(\S+)/;
      my $near = substr($1,0,10); 

      return($near, $near);

     # die( "Error inside the lexical analyzer near '". $near
     #     ."'. Line: ".$self->line()
     #     .". File: '".$self->YYFilename()."'. No match found.\n");
    }
  }
;


#line 3512 ./ansic.pm

my $warnmessage =<< "EOFWARN";
Warning!: Did you changed the \@ansic::ISA variable inside the header section of the eyapp program?
EOFWARN

sub new {
  my($class)=shift;
  ref($class) and $class=ref($class);

  warn $warnmessage unless __PACKAGE__->isa('Parse::Eyapp::Driver'); 
  my($self)=$class->SUPER::new( 
    yyversion => '1.182',
    yyGRAMMAR  =>
[#[productionNameAndLabel => lhs, [ rhs], bypass]]
  [ '_SUPERSTART' => '$start', [ 'translation_unit', '$end' ], 0 ],
  [ 'primaryExpression_is_IDENTIFIER' => 'primary_expression', [ 'IDENTIFIER' ], 0 ],
  [ 'primaryExpression_is_CONSTANT' => 'primary_expression', [ 'CONSTANT' ], 0 ],
  [ 'primaryExpression_is_STRING_LITERAL' => 'primary_expression', [ 'STRING_LITERAL' ], 0 ],
  [ 'primaryExpression_is_LP_expression_RP' => 'primary_expression', [ '(', 'expression', ')' ], 0 ],
  [ 'postfixExpression_is_primaryExpression' => 'postfix_expression', [ 'primary_expression' ], 0 ],
  [ 'postfixExpression_is_postfixExpression_LB_expression_RB' => 'postfix_expression', [ 'postfix_expression', '[', 'expression', ']' ], 0 ],
  [ 'postfixExpression_is_postfixExpression_LP_RP' => 'postfix_expression', [ 'postfix_expression', '(', ')' ], 0 ],
  [ 'postfixExpression_is_postfixExpression_LP_argumentExpressionList_RP' => 'postfix_expression', [ 'postfix_expression', '(', 'argument_expression_list', ')' ], 0 ],
  [ 'postfixExpression_is_postfixExpression_DOT_IDENTIFIER' => 'postfix_expression', [ 'postfix_expression', '.', 'IDENTIFIER' ], 0 ],
  [ 'postfixExpression_is_postfixExpression_PTR_OP_IDENTIFIER' => 'postfix_expression', [ 'postfix_expression', 'PTR_OP', 'IDENTIFIER' ], 0 ],
  [ 'postfixExpression_is_postfixExpression_INC_OP' => 'postfix_expression', [ 'postfix_expression', 'INC_OP' ], 0 ],
  [ 'postfixExpression_is_postfixExpression_DEC_OP' => 'postfix_expression', [ 'postfix_expression', 'DEC_OP' ], 0 ],
  [ 'argumentExpressionList_is_assignmentExpression' => 'argument_expression_list', [ 'assignment_expression' ], 0 ],
  [ 'argumentExpressionList_is_argumentExpressionList_COMMA_assignmentExpression' => 'argument_expression_list', [ 'argument_expression_list', ',', 'assignment_expression' ], 0 ],
  [ 'unaryExpression_is_postfixExpression' => 'unary_expression', [ 'postfix_expression' ], 0 ],
  [ 'unaryExpression_is_INC_OP_unaryExpression' => 'unary_expression', [ 'INC_OP', 'unary_expression' ], 0 ],
  [ 'unaryExpression_is_DEC_OP_unaryExpression' => 'unary_expression', [ 'DEC_OP', 'unary_expression' ], 0 ],
  [ 'unaryExpression_is_unaryOperator_castExpression' => 'unary_expression', [ 'unary_operator', 'cast_expression' ], 0 ],
  [ 'unaryExpression_is_SIZEOF_unaryExpression' => 'unary_expression', [ 'SIZEOF', 'unary_expression' ], 0 ],
  [ 'unaryExpression_is_SIZEOF_LP_typeName_RP' => 'unary_expression', [ 'SIZEOF', '(', 'type_name', ')' ], 0 ],
  [ 'unaryOperator_is_AMP' => 'unary_operator', [ '&' ], 0 ],
  [ 'unaryOperator_is_STAR' => 'unary_operator', [ '*' ], 0 ],
  [ 'unaryOperator_is_PLUS' => 'unary_operator', [ '+' ], 0 ],
  [ 'unaryOperator_is_MINUS' => 'unary_operator', [ '-' ], 0 ],
  [ 'unaryOperator_is_BNOT' => 'unary_operator', [ '~' ], 0 ],
  [ 'unaryOperator_is_NOT' => 'unary_operator', [ '!' ], 0 ],
  [ 'castExpression_is_unaryExpression' => 'cast_expression', [ 'unary_expression' ], 0 ],
  [ 'castExpression_is_LP_typeName_RP_castExpression' => 'cast_expression', [ '(', 'type_name', ')', 'cast_expression' ], 0 ],
  [ 'multiplicativeExpression_is_castExpression' => 'multiplicative_expression', [ 'cast_expression' ], 0 ],
  [ 'multiplicativeExpression_is_multiplicativeExpression_STAR_castExpression' => 'multiplicative_expression', [ 'multiplicative_expression', '*', 'cast_expression' ], 0 ],
  [ 'multiplicativeExpression_is_multiplicativeExpression_DIV_castExpression' => 'multiplicative_expression', [ 'multiplicative_expression', '/', 'cast_expression' ], 0 ],
  [ 'multiplicativeExpression_is_multiplicativeExpression_PERCENT_castExpression' => 'multiplicative_expression', [ 'multiplicative_expression', '%', 'cast_expression' ], 0 ],
  [ 'additiveExpression_is_multiplicativeExpression' => 'additive_expression', [ 'multiplicative_expression' ], 0 ],
  [ 'additiveExpression_is_additiveExpression_PLUS_multiplicativeExpression' => 'additive_expression', [ 'additive_expression', '+', 'multiplicative_expression' ], 0 ],
  [ 'additiveExpression_is_additiveExpression_MINUS_multiplicativeExpression' => 'additive_expression', [ 'additive_expression', '-', 'multiplicative_expression' ], 0 ],
  [ 'shiftExpression_is_additiveExpression' => 'shift_expression', [ 'additive_expression' ], 0 ],
  [ 'shiftExpression_is_shiftExpression_LEFT_OP_additiveExpression' => 'shift_expression', [ 'shift_expression', 'LEFT_OP', 'additive_expression' ], 0 ],
  [ 'shiftExpression_is_shiftExpression_RIGHT_OP_additiveExpression' => 'shift_expression', [ 'shift_expression', 'RIGHT_OP', 'additive_expression' ], 0 ],
  [ 'relationalExpression_is_shiftExpression' => 'relational_expression', [ 'shift_expression' ], 0 ],
  [ 'relationalExpression_is_relationalExpression_LT_shiftExpression' => 'relational_expression', [ 'relational_expression', '<', 'shift_expression' ], 0 ],
  [ 'relationalExpression_is_relationalExpression_GT_shiftExpression' => 'relational_expression', [ 'relational_expression', '>', 'shift_expression' ], 0 ],
  [ 'relationalExpression_is_relationalExpression_LE_OP_shiftExpression' => 'relational_expression', [ 'relational_expression', 'LE_OP', 'shift_expression' ], 0 ],
  [ 'relationalExpression_is_relationalExpression_GE_OP_shiftExpression' => 'relational_expression', [ 'relational_expression', 'GE_OP', 'shift_expression' ], 0 ],
  [ 'equalityExpression_is_relationalExpression' => 'equality_expression', [ 'relational_expression' ], 0 ],
  [ 'equalityExpression_is_equalityExpression_EQ_OP_relationalExpression' => 'equality_expression', [ 'equality_expression', 'EQ_OP', 'relational_expression' ], 0 ],
  [ 'equalityExpression_is_equalityExpression_NE_OP_relationalExpression' => 'equality_expression', [ 'equality_expression', 'NE_OP', 'relational_expression' ], 0 ],
  [ 'andExpression_is_equalityExpression' => 'and_expression', [ 'equality_expression' ], 0 ],
  [ 'andExpression_is_andExpression_AMP_equalityExpression' => 'and_expression', [ 'and_expression', '&', 'equality_expression' ], 0 ],
  [ 'exclusiveOrExpression_is_andExpression' => 'exclusive_or_expression', [ 'and_expression' ], 0 ],
  [ 'exclusiveOrExpression_is_exclusiveOrExpression_XOR_andExpression' => 'exclusive_or_expression', [ 'exclusive_or_expression', '^', 'and_expression' ], 0 ],
  [ 'inclusiveOrExpression_is_exclusiveOrExpression' => 'inclusive_or_expression', [ 'exclusive_or_expression' ], 0 ],
  [ 'inclusiveOrExpression_is_inclusiveOrExpression_OR_exclusiveOrExpression' => 'inclusive_or_expression', [ 'inclusive_or_expression', '|', 'exclusive_or_expression' ], 0 ],
  [ 'logicalAndExpression_is_inclusiveOrExpression' => 'logical_and_expression', [ 'inclusive_or_expression' ], 0 ],
  [ 'logicalAndExpression_is_logicalAndExpression_AND_OP_inclusiveOrExpression' => 'logical_and_expression', [ 'logical_and_expression', 'AND_OP', 'inclusive_or_expression' ], 0 ],
  [ 'logicalOrExpression_is_logicalAndExpression' => 'logical_or_expression', [ 'logical_and_expression' ], 0 ],
  [ 'logicalOrExpression_is_logicalOrExpression_OR_OP_logicalAndExpression' => 'logical_or_expression', [ 'logical_or_expression', 'OR_OP', 'logical_and_expression' ], 0 ],
  [ 'conditionalExpression_is_logicalOrExpression' => 'conditional_expression', [ 'logical_or_expression' ], 0 ],
  [ 'conditionalExpression_is_logicalOrExpression_QUESTION_expression_COLON_conditionalExpression' => 'conditional_expression', [ 'logical_or_expression', '?', 'expression', ':', 'conditional_expression' ], 0 ],
  [ 'assignmentExpression_is_conditionalExpression' => 'assignment_expression', [ 'conditional_expression' ], 0 ],
  [ 'assignmentExpression_is_unaryExpression_assignmentOperator_assignmentExpression' => 'assignment_expression', [ 'unary_expression', 'assignment_operator', 'assignment_expression' ], 0 ],
  [ 'assignmentOperator_is_ASSIGN' => 'assignment_operator', [ '=' ], 0 ],
  [ 'assignmentOperator_is_MUL_ASSIGN' => 'assignment_operator', [ 'MUL_ASSIGN' ], 0 ],
  [ 'assignmentOperator_is_DIV_ASSIGN' => 'assignment_operator', [ 'DIV_ASSIGN' ], 0 ],
  [ 'assignmentOperator_is_MOD_ASSIGN' => 'assignment_operator', [ 'MOD_ASSIGN' ], 0 ],
  [ 'assignmentOperator_is_ADD_ASSIGN' => 'assignment_operator', [ 'ADD_ASSIGN' ], 0 ],
  [ 'assignmentOperator_is_SUB_ASSIGN' => 'assignment_operator', [ 'SUB_ASSIGN' ], 0 ],
  [ 'assignmentOperator_is_LEFT_ASSIGN' => 'assignment_operator', [ 'LEFT_ASSIGN' ], 0 ],
  [ 'assignmentOperator_is_RIGHT_ASSIGN' => 'assignment_operator', [ 'RIGHT_ASSIGN' ], 0 ],
  [ 'assignmentOperator_is_AND_ASSIGN' => 'assignment_operator', [ 'AND_ASSIGN' ], 0 ],
  [ 'assignmentOperator_is_XOR_ASSIGN' => 'assignment_operator', [ 'XOR_ASSIGN' ], 0 ],
  [ 'assignmentOperator_is_OR_ASSIGN' => 'assignment_operator', [ 'OR_ASSIGN' ], 0 ],
  [ 'expression_is_assignmentExpression' => 'expression', [ 'assignment_expression' ], 0 ],
  [ 'expression_is_expression_COMMA_assignmentExpression' => 'expression', [ 'expression', ',', 'assignment_expression' ], 0 ],
  [ 'constantExpression_is_conditionalExpression' => 'constant_expression', [ 'conditional_expression' ], 0 ],
  [ 'declaration_is_declarationSpecifiers_SC' => 'declaration', [ 'declaration_specifiers', ';' ], 0 ],
  [ 'declaration_is_declarationSpecifiers_initDeclaratorList_SC' => 'declaration', [ 'declaration_specifiers', 'init_declarator_list', ';' ], 0 ],
  [ 'declarationSpecifiers_is_storageClassSpecifier' => 'declaration_specifiers', [ 'storage_class_specifier' ], 0 ],
  [ 'declarationSpecifiers_is_storageClassSpecifier_declarationSpecifiers' => 'declaration_specifiers', [ 'storage_class_specifier', 'declaration_specifiers' ], 0 ],
  [ 'declarationSpecifiers_is_typeSpecifier' => 'declaration_specifiers', [ 'type_specifier' ], 0 ],
  [ 'declarationSpecifiers_is_typeSpecifier_declarationSpecifiers' => 'declaration_specifiers', [ 'type_specifier', 'declaration_specifiers' ], 0 ],
  [ 'declarationSpecifiers_is_typeQualifier' => 'declaration_specifiers', [ 'type_qualifier' ], 0 ],
  [ 'declarationSpecifiers_is_typeQualifier_declarationSpecifiers' => 'declaration_specifiers', [ 'type_qualifier', 'declaration_specifiers' ], 0 ],
  [ 'initDeclaratorList_is_initDeclarator' => 'init_declarator_list', [ 'init_declarator' ], 0 ],
  [ 'initDeclaratorList_is_initDeclaratorList_COMMA_initDeclarator' => 'init_declarator_list', [ 'init_declarator_list', ',', 'init_declarator' ], 0 ],
  [ 'initDeclarator_is_declarator' => 'init_declarator', [ 'declarator' ], 0 ],
  [ 'initDeclarator_is_declarator_ASSIGN_initializer' => 'init_declarator', [ 'declarator', '=', 'initializer' ], 0 ],
  [ 'storageClassSpecifier_is_TYPEDEF' => 'storage_class_specifier', [ 'TYPEDEF' ], 0 ],
  [ 'storageClassSpecifier_is_EXTERN' => 'storage_class_specifier', [ 'EXTERN' ], 0 ],
  [ 'storageClassSpecifier_is_STATIC' => 'storage_class_specifier', [ 'STATIC' ], 0 ],
  [ 'storageClassSpecifier_is_AUTO' => 'storage_class_specifier', [ 'AUTO' ], 0 ],
  [ 'storageClassSpecifier_is_REGISTER' => 'storage_class_specifier', [ 'REGISTER' ], 0 ],
  [ 'typeSpecifier_is_VOID' => 'type_specifier', [ 'VOID' ], 0 ],
  [ 'typeSpecifier_is_CHAR' => 'type_specifier', [ 'CHAR' ], 0 ],
  [ 'typeSpecifier_is_SHORT' => 'type_specifier', [ 'SHORT' ], 0 ],
  [ 'typeSpecifier_is_INT' => 'type_specifier', [ 'INT' ], 0 ],
  [ 'typeSpecifier_is_LONG' => 'type_specifier', [ 'LONG' ], 0 ],
  [ 'typeSpecifier_is_FLOAT' => 'type_specifier', [ 'FLOAT' ], 0 ],
  [ 'typeSpecifier_is_DOUBLE' => 'type_specifier', [ 'DOUBLE' ], 0 ],
  [ 'typeSpecifier_is_SIGNED' => 'type_specifier', [ 'SIGNED' ], 0 ],
  [ 'typeSpecifier_is_UNSIGNED' => 'type_specifier', [ 'UNSIGNED' ], 0 ],
  [ 'typeSpecifier_is_structOrUnionSpecifier' => 'type_specifier', [ 'struct_or_union_specifier' ], 0 ],
  [ 'typeSpecifier_is_enumSpecifier' => 'type_specifier', [ 'enum_specifier' ], 0 ],
  [ 'typeSpecifier_is_TYPE_NAME' => 'type_specifier', [ 'TYPE_NAME' ], 0 ],
  [ 'structOrUnionSpecifier_is_structOrUnion_IDENTIFIER_OC_structDeclarationList_CC' => 'struct_or_union_specifier', [ 'struct_or_union', 'IDENTIFIER', '{', 'struct_declaration_list', '}' ], 0 ],
  [ 'structOrUnionSpecifier_is_structOrUnion_OC_structDeclarationList_CC' => 'struct_or_union_specifier', [ 'struct_or_union', '{', 'struct_declaration_list', '}' ], 0 ],
  [ 'structOrUnionSpecifier_is_structOrUnion_IDENTIFIER' => 'struct_or_union_specifier', [ 'struct_or_union', 'IDENTIFIER' ], 0 ],
  [ 'structOrUnion_is_STRUCT' => 'struct_or_union', [ 'STRUCT' ], 0 ],
  [ 'structOrUnion_is_UNION' => 'struct_or_union', [ 'UNION' ], 0 ],
  [ 'structDeclarationList_is_structDeclaration' => 'struct_declaration_list', [ 'struct_declaration' ], 0 ],
  [ 'structDeclarationList_is_structDeclarationList_structDeclaration' => 'struct_declaration_list', [ 'struct_declaration_list', 'struct_declaration' ], 0 ],
  [ 'structDeclaration_is_specifierQualifierList_structDeclaratorList_SC' => 'struct_declaration', [ 'specifier_qualifier_list', 'struct_declarator_list', ';' ], 0 ],
  [ 'specifierQualifierList_is_typeSpecifier_specifierQualifierList' => 'specifier_qualifier_list', [ 'type_specifier', 'specifier_qualifier_list' ], 0 ],
  [ 'specifierQualifierList_is_typeSpecifier' => 'specifier_qualifier_list', [ 'type_specifier' ], 0 ],
  [ 'specifierQualifierList_is_typeQualifier_specifierQualifierList' => 'specifier_qualifier_list', [ 'type_qualifier', 'specifier_qualifier_list' ], 0 ],
  [ 'specifierQualifierList_is_typeQualifier' => 'specifier_qualifier_list', [ 'type_qualifier' ], 0 ],
  [ 'structDeclaratorList_is_structDeclarator' => 'struct_declarator_list', [ 'struct_declarator' ], 0 ],
  [ 'structDeclaratorList_is_structDeclaratorList_COMMA_structDeclarator' => 'struct_declarator_list', [ 'struct_declarator_list', ',', 'struct_declarator' ], 0 ],
  [ 'structDeclarator_is_declarator' => 'struct_declarator', [ 'declarator' ], 0 ],
  [ 'structDeclarator_is_COLON_constantExpression' => 'struct_declarator', [ ':', 'constant_expression' ], 0 ],
  [ 'structDeclarator_is_declarator_COLON_constantExpression' => 'struct_declarator', [ 'declarator', ':', 'constant_expression' ], 0 ],
  [ 'enumSpecifier_is_ENUM_OC_enumeratorList_CC' => 'enum_specifier', [ 'ENUM', '{', 'enumerator_list', '}' ], 0 ],
  [ 'enumSpecifier_is_ENUM_IDENTIFIER_OC_enumeratorList_CC' => 'enum_specifier', [ 'ENUM', 'IDENTIFIER', '{', 'enumerator_list', '}' ], 0 ],
  [ 'enumSpecifier_is_ENUM_IDENTIFIER' => 'enum_specifier', [ 'ENUM', 'IDENTIFIER' ], 0 ],
  [ 'enumeratorList_is_enumerator' => 'enumerator_list', [ 'enumerator' ], 0 ],
  [ 'enumeratorList_is_enumeratorList_COMMA_enumerator' => 'enumerator_list', [ 'enumerator_list', ',', 'enumerator' ], 0 ],
  [ 'enumerator_is_IDENTIFIER' => 'enumerator', [ 'IDENTIFIER' ], 0 ],
  [ 'enumerator_is_IDENTIFIER_ASSIGN_constantExpression' => 'enumerator', [ 'IDENTIFIER', '=', 'constant_expression' ], 0 ],
  [ 'typeQualifier_is_CONST' => 'type_qualifier', [ 'CONST' ], 0 ],
  [ 'typeQualifier_is_VOLATILE' => 'type_qualifier', [ 'VOLATILE' ], 0 ],
  [ 'declarator_is_pointer_directDeclarator' => 'declarator', [ 'pointer', 'direct_declarator' ], 0 ],
  [ 'declarator_is_directDeclarator' => 'declarator', [ 'direct_declarator' ], 0 ],
  [ 'directDeclarator_is_IDENTIFIER' => 'direct_declarator', [ 'IDENTIFIER' ], 0 ],
  [ 'directDeclarator_is_LP_declarator_RP' => 'direct_declarator', [ '(', 'declarator', ')' ], 0 ],
  [ 'directDeclarator_is_directDeclarator_LB_constantExpression_RB' => 'direct_declarator', [ 'direct_declarator', '[', 'constant_expression', ']' ], 0 ],
  [ 'directDeclarator_is_directDeclarator_LB_RB' => 'direct_declarator', [ 'direct_declarator', '[', ']' ], 0 ],
  [ 'directDeclarator_is_directDeclarator_LP_parameterTypeList_RP' => 'direct_declarator', [ 'direct_declarator', '(', 'parameter_type_list', ')' ], 0 ],
  [ 'directDeclarator_is_directDeclarator_LP_identifierList_RP' => 'direct_declarator', [ 'direct_declarator', '(', 'identifier_list', ')' ], 0 ],
  [ 'directDeclarator_is_directDeclarator_LP_RP' => 'direct_declarator', [ 'direct_declarator', '(', ')' ], 0 ],
  [ 'pointer_is_STAR' => 'pointer', [ '*' ], 0 ],
  [ 'pointer_is_STAR_typeQualifierList' => 'pointer', [ '*', 'type_qualifier_list' ], 0 ],
  [ 'pointer_is_STAR_pointer' => 'pointer', [ '*', 'pointer' ], 0 ],
  [ 'pointer_is_STAR_typeQualifierList_pointer' => 'pointer', [ '*', 'type_qualifier_list', 'pointer' ], 0 ],
  [ 'typeQualifierList_is_typeQualifier' => 'type_qualifier_list', [ 'type_qualifier' ], 0 ],
  [ 'typeQualifierList_is_typeQualifierList_typeQualifier' => 'type_qualifier_list', [ 'type_qualifier_list', 'type_qualifier' ], 0 ],
  [ 'parameterTypeList_is_parameterList' => 'parameter_type_list', [ 'parameter_list' ], 0 ],
  [ 'parameterTypeList_is_parameterList_COMMA_ELLIPSIS' => 'parameter_type_list', [ 'parameter_list', ',', 'ELLIPSIS' ], 0 ],
  [ 'parameterList_is_parameterDeclaration' => 'parameter_list', [ 'parameter_declaration' ], 0 ],
  [ 'parameterList_is_parameterList_COMMA_parameterDeclaration' => 'parameter_list', [ 'parameter_list', ',', 'parameter_declaration' ], 0 ],
  [ 'parameterDeclaration_is_declarationSpecifiers_declarator' => 'parameter_declaration', [ 'declaration_specifiers', 'declarator' ], 0 ],
  [ 'parameterDeclaration_is_declarationSpecifiers_abstractDeclarator' => 'parameter_declaration', [ 'declaration_specifiers', 'abstract_declarator' ], 0 ],
  [ 'parameterDeclaration_is_declarationSpecifiers' => 'parameter_declaration', [ 'declaration_specifiers' ], 0 ],
  [ 'identifierList_is_IDENTIFIER' => 'identifier_list', [ 'IDENTIFIER' ], 0 ],
  [ 'identifierList_is_identifierList_COMMA_IDENTIFIER' => 'identifier_list', [ 'identifier_list', ',', 'IDENTIFIER' ], 0 ],
  [ 'typeName_is_specifierQualifierList' => 'type_name', [ 'specifier_qualifier_list' ], 0 ],
  [ 'typeName_is_specifierQualifierList_abstractDeclarator' => 'type_name', [ 'specifier_qualifier_list', 'abstract_declarator' ], 0 ],
  [ 'abstractDeclarator_is_pointer' => 'abstract_declarator', [ 'pointer' ], 0 ],
  [ 'abstractDeclarator_is_directAbstractDeclarator' => 'abstract_declarator', [ 'direct_abstract_declarator' ], 0 ],
  [ 'abstractDeclarator_is_pointer_directAbstractDeclarator' => 'abstract_declarator', [ 'pointer', 'direct_abstract_declarator' ], 0 ],
  [ 'directAbstractDeclarator_is_LP_abstractDeclarator_RP' => 'direct_abstract_declarator', [ '(', 'abstract_declarator', ')' ], 0 ],
  [ 'directAbstractDeclarator_is_LB_RB' => 'direct_abstract_declarator', [ '[', ']' ], 0 ],
  [ 'directAbstractDeclarator_is_LB_constantExpression_RB' => 'direct_abstract_declarator', [ '[', 'constant_expression', ']' ], 0 ],
  [ 'directAbstractDeclarator_is_directAbstractDeclarator_LB_RB' => 'direct_abstract_declarator', [ 'direct_abstract_declarator', '[', ']' ], 0 ],
  [ 'directAbstractDeclarator_is_directAbstractDeclarator_LB_constantExpression_RB' => 'direct_abstract_declarator', [ 'direct_abstract_declarator', '[', 'constant_expression', ']' ], 0 ],
  [ 'directAbstractDeclarator_is_LP_RP' => 'direct_abstract_declarator', [ '(', ')' ], 0 ],
  [ 'directAbstractDeclarator_is_LP_parameterTypeList_RP' => 'direct_abstract_declarator', [ '(', 'parameter_type_list', ')' ], 0 ],
  [ 'directAbstractDeclarator_is_directAbstractDeclarator_LP_RP' => 'direct_abstract_declarator', [ 'direct_abstract_declarator', '(', ')' ], 0 ],
  [ 'directAbstractDeclarator_is_directAbstractDeclarator_LP_parameterTypeList_RP' => 'direct_abstract_declarator', [ 'direct_abstract_declarator', '(', 'parameter_type_list', ')' ], 0 ],
  [ 'initializer_is_assignmentExpression' => 'initializer', [ 'assignment_expression' ], 0 ],
  [ 'initializer_is_OC_initializerList_CC' => 'initializer', [ '{', 'initializer_list', '}' ], 0 ],
  [ 'initializer_is_OC_initializerList_COMMA_CC' => 'initializer', [ '{', 'initializer_list', ',', '}' ], 0 ],
  [ 'initializerList_is_initializer' => 'initializer_list', [ 'initializer' ], 0 ],
  [ 'initializerList_is_initializerList_COMMA_initializer' => 'initializer_list', [ 'initializer_list', ',', 'initializer' ], 0 ],
  [ 'statement_is_labeledStatement' => 'statement', [ 'labeled_statement' ], 0 ],
  [ 'statement_is_compoundStatement' => 'statement', [ 'compound_statement' ], 0 ],
  [ 'statement_is_expressionStatement' => 'statement', [ 'expression_statement' ], 0 ],
  [ 'statement_is_selectionStatement' => 'statement', [ 'selection_statement' ], 0 ],
  [ 'statement_is_iterationStatement' => 'statement', [ 'iteration_statement' ], 0 ],
  [ 'statement_is_jumpStatement' => 'statement', [ 'jump_statement' ], 0 ],
  [ 'labeledStatement_is_IDENTIFIER_COLON_statement' => 'labeled_statement', [ 'IDENTIFIER', ':', 'statement' ], 0 ],
  [ 'labeledStatement_is_CASE_constantExpression_COLON_statement' => 'labeled_statement', [ 'CASE', 'constant_expression', ':', 'statement' ], 0 ],
  [ 'labeledStatement_is_DEFAULT_COLON_statement' => 'labeled_statement', [ 'DEFAULT', ':', 'statement' ], 0 ],
  [ 'compoundStatement_is_OC_CC' => 'compound_statement', [ '{', '}' ], 0 ],
  [ 'compoundStatement_is_OC_statementList_CC' => 'compound_statement', [ '{', 'statement_list', '}' ], 0 ],
  [ 'compoundStatement_is_OC_declarationList_CC' => 'compound_statement', [ '{', 'declaration_list', '}' ], 0 ],
  [ 'compoundStatement_is_OC_declarationList_statementList_CC' => 'compound_statement', [ '{', 'declaration_list', 'statement_list', '}' ], 0 ],
  [ 'declarationList_is_declaration' => 'declaration_list', [ 'declaration' ], 0 ],
  [ 'declarationList_is_declarationList_declaration' => 'declaration_list', [ 'declaration_list', 'declaration' ], 0 ],
  [ 'statementList_is_statement' => 'statement_list', [ 'statement' ], 0 ],
  [ 'statementList_is_statementList_statement' => 'statement_list', [ 'statement_list', 'statement' ], 0 ],
  [ 'expressionStatement_is_SC' => 'expression_statement', [ ';' ], 0 ],
  [ 'expressionStatement_is_expression_SC' => 'expression_statement', [ 'expression', ';' ], 0 ],
  [ 'selectionStatement_is_IF_LP_expression_RP_statement' => 'selection_statement', [ 'IF', '(', 'expression', ')', 'statement' ], 0 ],
  [ 'selectionStatement_is_IF_LP_expression_RP_statement_ELSE_statement' => 'selection_statement', [ 'IF', '(', 'expression', ')', 'statement', 'ELSE', 'statement' ], 0 ],
  [ 'selectionStatement_is_SWITCH_LP_expression_RP_statement' => 'selection_statement', [ 'SWITCH', '(', 'expression', ')', 'statement' ], 0 ],
  [ 'iterationStatement_is_WHILE_LP_expression_RP_statement' => 'iteration_statement', [ 'WHILE', '(', 'expression', ')', 'statement' ], 0 ],
  [ 'iterationStatement_is_DO_statement_WHILE_LP_expression_RP_SC' => 'iteration_statement', [ 'DO', 'statement', 'WHILE', '(', 'expression', ')', ';' ], 0 ],
  [ 'iterationStatement_is_FOR_LP_expressionStatement_expressionStatement_RP_statement' => 'iteration_statement', [ 'FOR', '(', 'expression_statement', 'expression_statement', ')', 'statement' ], 0 ],
  [ 'iterationStatement_is_FOR_LP_expressionStatement_expressionStatement_expression_RP_statement' => 'iteration_statement', [ 'FOR', '(', 'expression_statement', 'expression_statement', 'expression', ')', 'statement' ], 0 ],
  [ 'jumpStatement_is_GOTO_IDENTIFIER_SC' => 'jump_statement', [ 'GOTO', 'IDENTIFIER', ';' ], 0 ],
  [ 'jumpStatement_is_CONTINUE_SC' => 'jump_statement', [ 'CONTINUE', ';' ], 0 ],
  [ 'jumpStatement_is_BREAK_SC' => 'jump_statement', [ 'BREAK', ';' ], 0 ],
  [ 'jumpStatement_is_RETURN_SC' => 'jump_statement', [ 'RETURN', ';' ], 0 ],
  [ 'jumpStatement_is_RETURN_expression_SC' => 'jump_statement', [ 'RETURN', 'expression', ';' ], 0 ],
  [ 'translationUnit_is_externalDeclaration' => 'translation_unit', [ 'external_declaration' ], 0 ],
  [ 'translationUnit_is_translationUnit_externalDeclaration' => 'translation_unit', [ 'translation_unit', 'external_declaration' ], 0 ],
  [ 'externalDeclaration_is_functionDefinition' => 'external_declaration', [ 'function_definition' ], 0 ],
  [ 'externalDeclaration_is_declaration' => 'external_declaration', [ 'declaration' ], 0 ],
  [ 'functionDefinition_is_declarationSpecifiers_declarator_declarationList_compoundStatement' => 'function_definition', [ 'declaration_specifiers', 'declarator', 'declaration_list', 'compound_statement' ], 0 ],
  [ 'functionDefinition_is_declarationSpecifiers_declarator_compoundStatement' => 'function_definition', [ 'declaration_specifiers', 'declarator', 'compound_statement' ], 0 ],
  [ 'functionDefinition_is_declarator_declarationList_compoundStatement' => 'function_definition', [ 'declarator', 'declaration_list', 'compound_statement' ], 0 ],
  [ 'functionDefinition_is_declarator_compoundStatement' => 'function_definition', [ 'declarator', 'compound_statement' ], 0 ],
],
    yyLABELS  =>
{
  '_SUPERSTART' => 0,
  'primaryExpression_is_IDENTIFIER' => 1,
  'primaryExpression_is_CONSTANT' => 2,
  'primaryExpression_is_STRING_LITERAL' => 3,
  'primaryExpression_is_LP_expression_RP' => 4,
  'postfixExpression_is_primaryExpression' => 5,
  'postfixExpression_is_postfixExpression_LB_expression_RB' => 6,
  'postfixExpression_is_postfixExpression_LP_RP' => 7,
  'postfixExpression_is_postfixExpression_LP_argumentExpressionList_RP' => 8,
  'postfixExpression_is_postfixExpression_DOT_IDENTIFIER' => 9,
  'postfixExpression_is_postfixExpression_PTR_OP_IDENTIFIER' => 10,
  'postfixExpression_is_postfixExpression_INC_OP' => 11,
  'postfixExpression_is_postfixExpression_DEC_OP' => 12,
  'argumentExpressionList_is_assignmentExpression' => 13,
  'argumentExpressionList_is_argumentExpressionList_COMMA_assignmentExpression' => 14,
  'unaryExpression_is_postfixExpression' => 15,
  'unaryExpression_is_INC_OP_unaryExpression' => 16,
  'unaryExpression_is_DEC_OP_unaryExpression' => 17,
  'unaryExpression_is_unaryOperator_castExpression' => 18,
  'unaryExpression_is_SIZEOF_unaryExpression' => 19,
  'unaryExpression_is_SIZEOF_LP_typeName_RP' => 20,
  'unaryOperator_is_AMP' => 21,
  'unaryOperator_is_STAR' => 22,
  'unaryOperator_is_PLUS' => 23,
  'unaryOperator_is_MINUS' => 24,
  'unaryOperator_is_BNOT' => 25,
  'unaryOperator_is_NOT' => 26,
  'castExpression_is_unaryExpression' => 27,
  'castExpression_is_LP_typeName_RP_castExpression' => 28,
  'multiplicativeExpression_is_castExpression' => 29,
  'multiplicativeExpression_is_multiplicativeExpression_STAR_castExpression' => 30,
  'multiplicativeExpression_is_multiplicativeExpression_DIV_castExpression' => 31,
  'multiplicativeExpression_is_multiplicativeExpression_PERCENT_castExpression' => 32,
  'additiveExpression_is_multiplicativeExpression' => 33,
  'additiveExpression_is_additiveExpression_PLUS_multiplicativeExpression' => 34,
  'additiveExpression_is_additiveExpression_MINUS_multiplicativeExpression' => 35,
  'shiftExpression_is_additiveExpression' => 36,
  'shiftExpression_is_shiftExpression_LEFT_OP_additiveExpression' => 37,
  'shiftExpression_is_shiftExpression_RIGHT_OP_additiveExpression' => 38,
  'relationalExpression_is_shiftExpression' => 39,
  'relationalExpression_is_relationalExpression_LT_shiftExpression' => 40,
  'relationalExpression_is_relationalExpression_GT_shiftExpression' => 41,
  'relationalExpression_is_relationalExpression_LE_OP_shiftExpression' => 42,
  'relationalExpression_is_relationalExpression_GE_OP_shiftExpression' => 43,
  'equalityExpression_is_relationalExpression' => 44,
  'equalityExpression_is_equalityExpression_EQ_OP_relationalExpression' => 45,
  'equalityExpression_is_equalityExpression_NE_OP_relationalExpression' => 46,
  'andExpression_is_equalityExpression' => 47,
  'andExpression_is_andExpression_AMP_equalityExpression' => 48,
  'exclusiveOrExpression_is_andExpression' => 49,
  'exclusiveOrExpression_is_exclusiveOrExpression_XOR_andExpression' => 50,
  'inclusiveOrExpression_is_exclusiveOrExpression' => 51,
  'inclusiveOrExpression_is_inclusiveOrExpression_OR_exclusiveOrExpression' => 52,
  'logicalAndExpression_is_inclusiveOrExpression' => 53,
  'logicalAndExpression_is_logicalAndExpression_AND_OP_inclusiveOrExpression' => 54,
  'logicalOrExpression_is_logicalAndExpression' => 55,
  'logicalOrExpression_is_logicalOrExpression_OR_OP_logicalAndExpression' => 56,
  'conditionalExpression_is_logicalOrExpression' => 57,
  'conditionalExpression_is_logicalOrExpression_QUESTION_expression_COLON_conditionalExpression' => 58,
  'assignmentExpression_is_conditionalExpression' => 59,
  'assignmentExpression_is_unaryExpression_assignmentOperator_assignmentExpression' => 60,
  'assignmentOperator_is_ASSIGN' => 61,
  'assignmentOperator_is_MUL_ASSIGN' => 62,
  'assignmentOperator_is_DIV_ASSIGN' => 63,
  'assignmentOperator_is_MOD_ASSIGN' => 64,
  'assignmentOperator_is_ADD_ASSIGN' => 65,
  'assignmentOperator_is_SUB_ASSIGN' => 66,
  'assignmentOperator_is_LEFT_ASSIGN' => 67,
  'assignmentOperator_is_RIGHT_ASSIGN' => 68,
  'assignmentOperator_is_AND_ASSIGN' => 69,
  'assignmentOperator_is_XOR_ASSIGN' => 70,
  'assignmentOperator_is_OR_ASSIGN' => 71,
  'expression_is_assignmentExpression' => 72,
  'expression_is_expression_COMMA_assignmentExpression' => 73,
  'constantExpression_is_conditionalExpression' => 74,
  'declaration_is_declarationSpecifiers_SC' => 75,
  'declaration_is_declarationSpecifiers_initDeclaratorList_SC' => 76,
  'declarationSpecifiers_is_storageClassSpecifier' => 77,
  'declarationSpecifiers_is_storageClassSpecifier_declarationSpecifiers' => 78,
  'declarationSpecifiers_is_typeSpecifier' => 79,
  'declarationSpecifiers_is_typeSpecifier_declarationSpecifiers' => 80,
  'declarationSpecifiers_is_typeQualifier' => 81,
  'declarationSpecifiers_is_typeQualifier_declarationSpecifiers' => 82,
  'initDeclaratorList_is_initDeclarator' => 83,
  'initDeclaratorList_is_initDeclaratorList_COMMA_initDeclarator' => 84,
  'initDeclarator_is_declarator' => 85,
  'initDeclarator_is_declarator_ASSIGN_initializer' => 86,
  'storageClassSpecifier_is_TYPEDEF' => 87,
  'storageClassSpecifier_is_EXTERN' => 88,
  'storageClassSpecifier_is_STATIC' => 89,
  'storageClassSpecifier_is_AUTO' => 90,
  'storageClassSpecifier_is_REGISTER' => 91,
  'typeSpecifier_is_VOID' => 92,
  'typeSpecifier_is_CHAR' => 93,
  'typeSpecifier_is_SHORT' => 94,
  'typeSpecifier_is_INT' => 95,
  'typeSpecifier_is_LONG' => 96,
  'typeSpecifier_is_FLOAT' => 97,
  'typeSpecifier_is_DOUBLE' => 98,
  'typeSpecifier_is_SIGNED' => 99,
  'typeSpecifier_is_UNSIGNED' => 100,
  'typeSpecifier_is_structOrUnionSpecifier' => 101,
  'typeSpecifier_is_enumSpecifier' => 102,
  'typeSpecifier_is_TYPE_NAME' => 103,
  'structOrUnionSpecifier_is_structOrUnion_IDENTIFIER_OC_structDeclarationList_CC' => 104,
  'structOrUnionSpecifier_is_structOrUnion_OC_structDeclarationList_CC' => 105,
  'structOrUnionSpecifier_is_structOrUnion_IDENTIFIER' => 106,
  'structOrUnion_is_STRUCT' => 107,
  'structOrUnion_is_UNION' => 108,
  'structDeclarationList_is_structDeclaration' => 109,
  'structDeclarationList_is_structDeclarationList_structDeclaration' => 110,
  'structDeclaration_is_specifierQualifierList_structDeclaratorList_SC' => 111,
  'specifierQualifierList_is_typeSpecifier_specifierQualifierList' => 112,
  'specifierQualifierList_is_typeSpecifier' => 113,
  'specifierQualifierList_is_typeQualifier_specifierQualifierList' => 114,
  'specifierQualifierList_is_typeQualifier' => 115,
  'structDeclaratorList_is_structDeclarator' => 116,
  'structDeclaratorList_is_structDeclaratorList_COMMA_structDeclarator' => 117,
  'structDeclarator_is_declarator' => 118,
  'structDeclarator_is_COLON_constantExpression' => 119,
  'structDeclarator_is_declarator_COLON_constantExpression' => 120,
  'enumSpecifier_is_ENUM_OC_enumeratorList_CC' => 121,
  'enumSpecifier_is_ENUM_IDENTIFIER_OC_enumeratorList_CC' => 122,
  'enumSpecifier_is_ENUM_IDENTIFIER' => 123,
  'enumeratorList_is_enumerator' => 124,
  'enumeratorList_is_enumeratorList_COMMA_enumerator' => 125,
  'enumerator_is_IDENTIFIER' => 126,
  'enumerator_is_IDENTIFIER_ASSIGN_constantExpression' => 127,
  'typeQualifier_is_CONST' => 128,
  'typeQualifier_is_VOLATILE' => 129,
  'declarator_is_pointer_directDeclarator' => 130,
  'declarator_is_directDeclarator' => 131,
  'directDeclarator_is_IDENTIFIER' => 132,
  'directDeclarator_is_LP_declarator_RP' => 133,
  'directDeclarator_is_directDeclarator_LB_constantExpression_RB' => 134,
  'directDeclarator_is_directDeclarator_LB_RB' => 135,
  'directDeclarator_is_directDeclarator_LP_parameterTypeList_RP' => 136,
  'directDeclarator_is_directDeclarator_LP_identifierList_RP' => 137,
  'directDeclarator_is_directDeclarator_LP_RP' => 138,
  'pointer_is_STAR' => 139,
  'pointer_is_STAR_typeQualifierList' => 140,
  'pointer_is_STAR_pointer' => 141,
  'pointer_is_STAR_typeQualifierList_pointer' => 142,
  'typeQualifierList_is_typeQualifier' => 143,
  'typeQualifierList_is_typeQualifierList_typeQualifier' => 144,
  'parameterTypeList_is_parameterList' => 145,
  'parameterTypeList_is_parameterList_COMMA_ELLIPSIS' => 146,
  'parameterList_is_parameterDeclaration' => 147,
  'parameterList_is_parameterList_COMMA_parameterDeclaration' => 148,
  'parameterDeclaration_is_declarationSpecifiers_declarator' => 149,
  'parameterDeclaration_is_declarationSpecifiers_abstractDeclarator' => 150,
  'parameterDeclaration_is_declarationSpecifiers' => 151,
  'identifierList_is_IDENTIFIER' => 152,
  'identifierList_is_identifierList_COMMA_IDENTIFIER' => 153,
  'typeName_is_specifierQualifierList' => 154,
  'typeName_is_specifierQualifierList_abstractDeclarator' => 155,
  'abstractDeclarator_is_pointer' => 156,
  'abstractDeclarator_is_directAbstractDeclarator' => 157,
  'abstractDeclarator_is_pointer_directAbstractDeclarator' => 158,
  'directAbstractDeclarator_is_LP_abstractDeclarator_RP' => 159,
  'directAbstractDeclarator_is_LB_RB' => 160,
  'directAbstractDeclarator_is_LB_constantExpression_RB' => 161,
  'directAbstractDeclarator_is_directAbstractDeclarator_LB_RB' => 162,
  'directAbstractDeclarator_is_directAbstractDeclarator_LB_constantExpression_RB' => 163,
  'directAbstractDeclarator_is_LP_RP' => 164,
  'directAbstractDeclarator_is_LP_parameterTypeList_RP' => 165,
  'directAbstractDeclarator_is_directAbstractDeclarator_LP_RP' => 166,
  'directAbstractDeclarator_is_directAbstractDeclarator_LP_parameterTypeList_RP' => 167,
  'initializer_is_assignmentExpression' => 168,
  'initializer_is_OC_initializerList_CC' => 169,
  'initializer_is_OC_initializerList_COMMA_CC' => 170,
  'initializerList_is_initializer' => 171,
  'initializerList_is_initializerList_COMMA_initializer' => 172,
  'statement_is_labeledStatement' => 173,
  'statement_is_compoundStatement' => 174,
  'statement_is_expressionStatement' => 175,
  'statement_is_selectionStatement' => 176,
  'statement_is_iterationStatement' => 177,
  'statement_is_jumpStatement' => 178,
  'labeledStatement_is_IDENTIFIER_COLON_statement' => 179,
  'labeledStatement_is_CASE_constantExpression_COLON_statement' => 180,
  'labeledStatement_is_DEFAULT_COLON_statement' => 181,
  'compoundStatement_is_OC_CC' => 182,
  'compoundStatement_is_OC_statementList_CC' => 183,
  'compoundStatement_is_OC_declarationList_CC' => 184,
  'compoundStatement_is_OC_declarationList_statementList_CC' => 185,
  'declarationList_is_declaration' => 186,
  'declarationList_is_declarationList_declaration' => 187,
  'statementList_is_statement' => 188,
  'statementList_is_statementList_statement' => 189,
  'expressionStatement_is_SC' => 190,
  'expressionStatement_is_expression_SC' => 191,
  'selectionStatement_is_IF_LP_expression_RP_statement' => 192,
  'selectionStatement_is_IF_LP_expression_RP_statement_ELSE_statement' => 193,
  'selectionStatement_is_SWITCH_LP_expression_RP_statement' => 194,
  'iterationStatement_is_WHILE_LP_expression_RP_statement' => 195,
  'iterationStatement_is_DO_statement_WHILE_LP_expression_RP_SC' => 196,
  'iterationStatement_is_FOR_LP_expressionStatement_expressionStatement_RP_statement' => 197,
  'iterationStatement_is_FOR_LP_expressionStatement_expressionStatement_expression_RP_statement' => 198,
  'jumpStatement_is_GOTO_IDENTIFIER_SC' => 199,
  'jumpStatement_is_CONTINUE_SC' => 200,
  'jumpStatement_is_BREAK_SC' => 201,
  'jumpStatement_is_RETURN_SC' => 202,
  'jumpStatement_is_RETURN_expression_SC' => 203,
  'translationUnit_is_externalDeclaration' => 204,
  'translationUnit_is_translationUnit_externalDeclaration' => 205,
  'externalDeclaration_is_functionDefinition' => 206,
  'externalDeclaration_is_declaration' => 207,
  'functionDefinition_is_declarationSpecifiers_declarator_declarationList_compoundStatement' => 208,
  'functionDefinition_is_declarationSpecifiers_declarator_compoundStatement' => 209,
  'functionDefinition_is_declarator_declarationList_compoundStatement' => 210,
  'functionDefinition_is_declarator_compoundStatement' => 211,
},
    yyTERMS  =>
{ '' => { ISSEMANTIC => 0 },
	'!' => { ISSEMANTIC => 0 },
	'%' => { ISSEMANTIC => 0 },
	'&' => { ISSEMANTIC => 0 },
	'(' => { ISSEMANTIC => 0 },
	')' => { ISSEMANTIC => 0 },
	'*' => { ISSEMANTIC => 0 },
	'+' => { ISSEMANTIC => 0 },
	',' => { ISSEMANTIC => 0 },
	'-' => { ISSEMANTIC => 0 },
	'.' => { ISSEMANTIC => 0 },
	'/' => { ISSEMANTIC => 0 },
	':' => { ISSEMANTIC => 0 },
	';' => { ISSEMANTIC => 0 },
	'<' => { ISSEMANTIC => 0 },
	'=' => { ISSEMANTIC => 0 },
	'>' => { ISSEMANTIC => 0 },
	'?' => { ISSEMANTIC => 0 },
	'[' => { ISSEMANTIC => 0 },
	']' => { ISSEMANTIC => 0 },
	'^' => { ISSEMANTIC => 0 },
	'{' => { ISSEMANTIC => 0 },
	'|' => { ISSEMANTIC => 0 },
	'}' => { ISSEMANTIC => 0 },
	'~' => { ISSEMANTIC => 0 },
	ADD_ASSIGN => { ISSEMANTIC => 1 },
	AND_ASSIGN => { ISSEMANTIC => 1 },
	AND_OP => { ISSEMANTIC => 1 },
	AUTO => { ISSEMANTIC => 1 },
	BREAK => { ISSEMANTIC => 1 },
	CASE => { ISSEMANTIC => 1 },
	CHAR => { ISSEMANTIC => 1 },
	CONST => { ISSEMANTIC => 1 },
	CONSTANT => { ISSEMANTIC => 1 },
	CONTINUE => { ISSEMANTIC => 1 },
	DEC_OP => { ISSEMANTIC => 1 },
	DEFAULT => { ISSEMANTIC => 1 },
	DIV_ASSIGN => { ISSEMANTIC => 1 },
	DO => { ISSEMANTIC => 1 },
	DOUBLE => { ISSEMANTIC => 1 },
	ELLIPSIS => { ISSEMANTIC => 1 },
	ELSE => { ISSEMANTIC => 1 },
	ENUM => { ISSEMANTIC => 1 },
	EQ_OP => { ISSEMANTIC => 1 },
	EXTERN => { ISSEMANTIC => 1 },
	FLOAT => { ISSEMANTIC => 1 },
	FOR => { ISSEMANTIC => 1 },
	GE_OP => { ISSEMANTIC => 1 },
	GOTO => { ISSEMANTIC => 1 },
	IDENTIFIER => { ISSEMANTIC => 1 },
	IF => { ISSEMANTIC => 1 },
	INC_OP => { ISSEMANTIC => 1 },
	INT => { ISSEMANTIC => 1 },
	LEFT_ASSIGN => { ISSEMANTIC => 1 },
	LEFT_OP => { ISSEMANTIC => 1 },
	LE_OP => { ISSEMANTIC => 1 },
	LONG => { ISSEMANTIC => 1 },
	MOD_ASSIGN => { ISSEMANTIC => 1 },
	MUL_ASSIGN => { ISSEMANTIC => 1 },
	NE_OP => { ISSEMANTIC => 1 },
	OR_ASSIGN => { ISSEMANTIC => 1 },
	OR_OP => { ISSEMANTIC => 1 },
	PTR_OP => { ISSEMANTIC => 1 },
	REGISTER => { ISSEMANTIC => 1 },
	RETURN => { ISSEMANTIC => 1 },
	RIGHT_ASSIGN => { ISSEMANTIC => 1 },
	RIGHT_OP => { ISSEMANTIC => 1 },
	SHORT => { ISSEMANTIC => 1 },
	SIGNED => { ISSEMANTIC => 1 },
	SIZEOF => { ISSEMANTIC => 1 },
	STATIC => { ISSEMANTIC => 1 },
	STRING_LITERAL => { ISSEMANTIC => 1 },
	STRUCT => { ISSEMANTIC => 1 },
	SUB_ASSIGN => { ISSEMANTIC => 1 },
	SWITCH => { ISSEMANTIC => 1 },
	TYPEDEF => { ISSEMANTIC => 1 },
	TYPE_NAME => { ISSEMANTIC => 1 },
	UNION => { ISSEMANTIC => 1 },
	UNSIGNED => { ISSEMANTIC => 1 },
	VOID => { ISSEMANTIC => 1 },
	VOLATILE => { ISSEMANTIC => 1 },
	WEAK => { ISSEMANTIC => 1 },
	WHILE => { ISSEMANTIC => 1 },
	XOR_ASSIGN => { ISSEMANTIC => 1 },
	error => { ISSEMANTIC => 0 },
},
    yyFILENAME  => 'ansic.eyp',
    yystates =>
[
	{#State 0
		ACTIONS => {
			'DOUBLE' => 2,
			'REGISTER' => 1,
			'ENUM' => 5,
			"(" => 27,
			'VOID' => 6,
			'SHORT' => 4,
			'EXTERN' => 31,
			'SIGNED' => 30,
			'VOLATILE' => 7,
			'INT' => 10,
			'TYPE_NAME' => 8,
			'CHAR' => 13,
			'UNION' => 14,
			'STATIC' => 11,
			'FLOAT' => 34,
			'LONG' => 20,
			'STRUCT' => 19,
			'UNSIGNED' => 18,
			'AUTO' => 35,
			"*" => 17,
			'TYPEDEF' => 21,
			'CONST' => 25,
			'IDENTIFIER' => 24
		},
		GOTOS => {
			'type_specifier' => 9,
			'pointer' => 33,
			'struct_or_union_specifier' => 32,
			'declarator' => 23,
			'direct_declarator' => 37,
			'storage_class_specifier' => 36,
			'type_qualifier' => 28,
			'enum_specifier' => 29,
			'translation_unit' => 22,
			'struct_or_union' => 3,
			'function_definition' => 16,
			'external_declaration' => 15,
			'declaration_specifiers' => 26,
			'declaration' => 12
		}
	},
	{#State 1
		DEFAULT => -91
	},
	{#State 2
		DEFAULT => -98
	},
	{#State 3
		ACTIONS => {
			'IDENTIFIER' => 38,
			"{" => 39
		}
	},
	{#State 4
		DEFAULT => -94
	},
	{#State 5
		ACTIONS => {
			'IDENTIFIER' => 40,
			"{" => 41
		}
	},
	{#State 6
		DEFAULT => -92
	},
	{#State 7
		DEFAULT => -129
	},
	{#State 8
		DEFAULT => -103
	},
	{#State 9
		ACTIONS => {
			'EXTERN' => 31,
			'SIGNED' => 30,
			'VOLATILE' => 7,
			'INT' => 10,
			'TYPE_NAME' => 8,
			'DOUBLE' => 2,
			'REGISTER' => 1,
			'VOID' => 6,
			'ENUM' => 5,
			'SHORT' => 4,
			'TYPEDEF' => 21,
			'CONST' => 25,
			'UNION' => 14,
			'CHAR' => 13,
			'STATIC' => 11,
			'FLOAT' => 34,
			'LONG' => 20,
			'STRUCT' => 19,
			'UNSIGNED' => 18,
			'AUTO' => 35
		},
		DEFAULT => -79,
		GOTOS => {
			'storage_class_specifier' => 36,
			'type_qualifier' => 28,
			'enum_specifier' => 29,
			'struct_or_union' => 3,
			'type_specifier' => 9,
			'declaration_specifiers' => 42,
			'struct_or_union_specifier' => 32
		}
	},
	{#State 10
		DEFAULT => -95
	},
	{#State 11
		DEFAULT => -89
	},
	{#State 12
		DEFAULT => -207
	},
	{#State 13
		DEFAULT => -93
	},
	{#State 14
		DEFAULT => -108
	},
	{#State 15
		DEFAULT => -204
	},
	{#State 16
		DEFAULT => -206
	},
	{#State 17
		ACTIONS => {
			'VOLATILE' => 7,
			'CONST' => 25,
			"*" => 17
		},
		DEFAULT => -139,
		GOTOS => {
			'type_qualifier_list' => 43,
			'type_qualifier' => 44,
			'pointer' => 45
		}
	},
	{#State 18
		DEFAULT => -100
	},
	{#State 19
		DEFAULT => -107
	},
	{#State 20
		DEFAULT => -96
	},
	{#State 21
		DEFAULT => -87
	},
	{#State 22
		ACTIONS => {
			'VOID' => 6,
			"(" => 27,
			'ENUM' => 5,
			'SHORT' => 4,
			'DOUBLE' => 2,
			'REGISTER' => 1,
			'TYPE_NAME' => 8,
			'INT' => 10,
			'SIGNED' => 30,
			'VOLATILE' => 7,
			'' => 46,
			'EXTERN' => 31,
			'STRUCT' => 19,
			"*" => 17,
			'UNSIGNED' => 18,
			'AUTO' => 35,
			'LONG' => 20,
			'STATIC' => 11,
			'FLOAT' => 34,
			'UNION' => 14,
			'CHAR' => 13,
			'CONST' => 25,
			'IDENTIFIER' => 24,
			'TYPEDEF' => 21
		},
		GOTOS => {
			'declaration_specifiers' => 26,
			'function_definition' => 16,
			'external_declaration' => 47,
			'struct_or_union' => 3,
			'declaration' => 12,
			'struct_or_union_specifier' => 32,
			'pointer' => 33,
			'type_specifier' => 9,
			'type_qualifier' => 28,
			'enum_specifier' => 29,
			'declarator' => 23,
			'storage_class_specifier' => 36,
			'direct_declarator' => 37
		}
	},
	{#State 23
		ACTIONS => {
			'LONG' => 20,
			'UNSIGNED' => 18,
			'AUTO' => 35,
			'STRUCT' => 19,
			"{" => 50,
			'CHAR' => 13,
			'UNION' => 14,
			'FLOAT' => 34,
			'STATIC' => 11,
			'CONST' => 25,
			'TYPEDEF' => 21,
			'SHORT' => 4,
			'ENUM' => 5,
			'VOID' => 6,
			'REGISTER' => 1,
			'DOUBLE' => 2,
			'INT' => 10,
			'TYPE_NAME' => 8,
			'EXTERN' => 31,
			'VOLATILE' => 7,
			'SIGNED' => 30
		},
		GOTOS => {
			'type_qualifier' => 28,
			'enum_specifier' => 29,
			'compound_statement' => 48,
			'storage_class_specifier' => 36,
			'struct_or_union_specifier' => 32,
			'type_specifier' => 9,
			'declaration' => 49,
			'declaration_list' => 52,
			'declaration_specifiers' => 51,
			'struct_or_union' => 3
		}
	},
	{#State 24
		DEFAULT => -132
	},
	{#State 25
		DEFAULT => -128
	},
	{#State 26
		ACTIONS => {
			";" => 54,
			"*" => 17,
			'IDENTIFIER' => 24,
			"(" => 27
		},
		GOTOS => {
			'declarator' => 53,
			'direct_declarator' => 37,
			'init_declarator' => 55,
			'init_declarator_list' => 56,
			'pointer' => 33
		}
	},
	{#State 27
		ACTIONS => {
			'IDENTIFIER' => 24,
			"(" => 27,
			"*" => 17
		},
		GOTOS => {
			'declarator' => 57,
			'direct_declarator' => 37,
			'pointer' => 33
		}
	},
	{#State 28
		ACTIONS => {
			'DOUBLE' => 2,
			'REGISTER' => 1,
			'VOID' => 6,
			'ENUM' => 5,
			'SHORT' => 4,
			'EXTERN' => 31,
			'SIGNED' => 30,
			'VOLATILE' => 7,
			'INT' => 10,
			'TYPE_NAME' => 8,
			'CHAR' => 13,
			'UNION' => 14,
			'STATIC' => 11,
			'FLOAT' => 34,
			'LONG' => 20,
			'STRUCT' => 19,
			'AUTO' => 35,
			'UNSIGNED' => 18,
			'TYPEDEF' => 21,
			'CONST' => 25
		},
		DEFAULT => -81,
		GOTOS => {
			'declaration_specifiers' => 58,
			'struct_or_union_specifier' => 32,
			'struct_or_union' => 3,
			'type_specifier' => 9,
			'type_qualifier' => 28,
			'enum_specifier' => 29,
			'storage_class_specifier' => 36
		}
	},
	{#State 29
		DEFAULT => -102
	},
	{#State 30
		DEFAULT => -99
	},
	{#State 31
		DEFAULT => -88
	},
	{#State 32
		DEFAULT => -101
	},
	{#State 33
		ACTIONS => {
			'IDENTIFIER' => 24,
			"(" => 27
		},
		GOTOS => {
			'direct_declarator' => 59
		}
	},
	{#State 34
		DEFAULT => -97
	},
	{#State 35
		DEFAULT => -90
	},
	{#State 36
		ACTIONS => {
			'UNION' => 14,
			'CHAR' => 13,
			'FLOAT' => 34,
			'STATIC' => 11,
			'LONG' => 20,
			'UNSIGNED' => 18,
			'AUTO' => 35,
			'STRUCT' => 19,
			'TYPEDEF' => 21,
			'CONST' => 25,
			'REGISTER' => 1,
			'DOUBLE' => 2,
			'SHORT' => 4,
			'VOID' => 6,
			'ENUM' => 5,
			'EXTERN' => 31,
			'VOLATILE' => 7,
			'SIGNED' => 30,
			'INT' => 10,
			'TYPE_NAME' => 8
		},
		DEFAULT => -77,
		GOTOS => {
			'type_specifier' => 9,
			'struct_or_union' => 3,
			'declaration_specifiers' => 60,
			'struct_or_union_specifier' => 32,
			'storage_class_specifier' => 36,
			'enum_specifier' => 29,
			'type_qualifier' => 28
		}
	},
	{#State 37
		ACTIONS => {
			"[" => 61,
			"(" => 62
		},
		DEFAULT => -131
	},
	{#State 38
		ACTIONS => {
			"{" => 63
		},
		DEFAULT => -106
	},
	{#State 39
		ACTIONS => {
			'SIGNED' => 30,
			'VOLATILE' => 7,
			'CONST' => 25,
			'INT' => 10,
			'TYPE_NAME' => 8,
			'CHAR' => 13,
			'UNION' => 14,
			'DOUBLE' => 2,
			'FLOAT' => 34,
			'VOID' => 6,
			'ENUM' => 5,
			'LONG' => 20,
			'SHORT' => 4,
			'STRUCT' => 19,
			'UNSIGNED' => 18
		},
		GOTOS => {
			'struct_declaration' => 64,
			'type_qualifier' => 68,
			'enum_specifier' => 29,
			'type_specifier' => 66,
			'struct_declaration_list' => 67,
			'specifier_qualifier_list' => 65,
			'struct_or_union_specifier' => 32,
			'struct_or_union' => 3
		}
	},
	{#State 40
		ACTIONS => {
			"{" => 69
		},
		DEFAULT => -123
	},
	{#State 41
		ACTIONS => {
			'IDENTIFIER' => 72
		},
		GOTOS => {
			'enumerator' => 71,
			'enumerator_list' => 70
		}
	},
	{#State 42
		DEFAULT => -80
	},
	{#State 43
		ACTIONS => {
			'VOLATILE' => 7,
			'CONST' => 25,
			"*" => 17
		},
		DEFAULT => -140,
		GOTOS => {
			'type_qualifier' => 74,
			'pointer' => 73
		}
	},
	{#State 44
		DEFAULT => -143
	},
	{#State 45
		DEFAULT => -141
	},
	{#State 46
		DEFAULT => 0
	},
	{#State 47
		DEFAULT => -205
	},
	{#State 48
		DEFAULT => -211
	},
	{#State 49
		DEFAULT => -186
	},
	{#State 50
		ACTIONS => {
			"{" => 50,
			'FLOAT' => 34,
			'SIZEOF' => 105,
			'AUTO' => 35,
			'DO' => 76,
			'GOTO' => 75,
			"~" => 78,
			"!" => 104,
			"(" => 85,
			'FOR' => 108,
			'EXTERN' => 31,
			'SIGNED' => 30,
			'RETURN' => 84,
			"&" => 80,
			'INC_OP' => 107,
			'UNION' => 14,
			'CHAR' => 13,
			'STATIC' => 11,
			'LONG' => 20,
			'STRUCT' => 19,
			"*" => 119,
			'UNSIGNED' => 18,
			'CONSTANT' => 117,
			'CASE' => 94,
			'TYPEDEF' => 21,
			";" => 93,
			'DEC_OP' => 89,
			'CONST' => 25,
			'IDENTIFIER' => 88,
			"}" => 113,
			'STRING_LITERAL' => 116,
			'CONTINUE' => 114,
			"-" => 115,
			'IF' => 102,
			'DOUBLE' => 2,
			"+" => 127,
			'REGISTER' => 1,
			'VOID' => 6,
			'DEFAULT' => 125,
			'ENUM' => 5,
			'BREAK' => 124,
			'SHORT' => 4,
			'WHILE' => 101,
			'VOLATILE' => 7,
			'SWITCH' => 98,
			'INT' => 10,
			'TYPE_NAME' => 8
		},
		GOTOS => {
			'relational_expression' => 106,
			'shift_expression' => 79,
			'primary_expression' => 77,
			'storage_class_specifier' => 36,
			'postfix_expression' => 103,
			'assignment_expression' => 112,
			'expression_statement' => 111,
			'declaration_list' => 87,
			'declaration_specifiers' => 51,
			'jump_statement' => 86,
			'logical_and_expression' => 110,
			'exclusive_or_expression' => 109,
			'cast_expression' => 83,
			'enum_specifier' => 29,
			'type_qualifier' => 28,
			'and_expression' => 82,
			'struct_or_union_specifier' => 32,
			'logical_or_expression' => 81,
			'statement_list' => 120,
			'expression' => 96,
			'declaration' => 49,
			'multiplicative_expression' => 122,
			'labeled_statement' => 97,
			'conditional_expression' => 121,
			'iteration_statement' => 95,
			'additive_expression' => 91,
			'unary_expression' => 118,
			'compound_statement' => 92,
			'unary_operator' => 90,
			'equality_expression' => 126,
			'inclusive_or_expression' => 100,
			'struct_or_union' => 3,
			'statement' => 99,
			'selection_statement' => 123,
			'type_specifier' => 9
		}
	},
	{#State 51
		ACTIONS => {
			"(" => 27,
			'IDENTIFIER' => 24,
			"*" => 17,
			";" => 54
		},
		GOTOS => {
			'declarator' => 128,
			'direct_declarator' => 37,
			'init_declarator_list' => 56,
			'init_declarator' => 55,
			'pointer' => 33
		}
	},
	{#State 52
		ACTIONS => {
			'INT' => 10,
			'TYPE_NAME' => 8,
			'EXTERN' => 31,
			'SIGNED' => 30,
			'VOLATILE' => 7,
			'ENUM' => 5,
			'VOID' => 6,
			'SHORT' => 4,
			'DOUBLE' => 2,
			'REGISTER' => 1,
			'CONST' => 25,
			'TYPEDEF' => 21,
			'LONG' => 20,
			'STRUCT' => 19,
			'AUTO' => 35,
			'UNSIGNED' => 18,
			'UNION' => 14,
			'CHAR' => 13,
			"{" => 50,
			'STATIC' => 11,
			'FLOAT' => 34
		},
		GOTOS => {
			'compound_statement' => 129,
			'storage_class_specifier' => 36,
			'enum_specifier' => 29,
			'type_qualifier' => 28,
			'type_specifier' => 9,
			'struct_or_union_specifier' => 32,
			'declaration' => 130,
			'struct_or_union' => 3,
			'declaration_specifiers' => 51
		}
	},
	{#State 53
		ACTIONS => {
			'LONG' => 20,
			'STRUCT' => 19,
			'AUTO' => 35,
			'UNSIGNED' => 18,
			'CHAR' => 13,
			'UNION' => 14,
			"{" => 50,
			'STATIC' => 11,
			"=" => 133,
			'FLOAT' => 34,
			'CONST' => 25,
			'TYPEDEF' => 21,
			'VOID' => 6,
			'ENUM' => 5,
			'SHORT' => 4,
			'DOUBLE' => 2,
			'REGISTER' => 1,
			'INT' => 10,
			'TYPE_NAME' => 8,
			'EXTERN' => 31,
			'SIGNED' => 30,
			'VOLATILE' => 7
		},
		DEFAULT => -85,
		GOTOS => {
			'declaration_list' => 131,
			'declaration' => 49,
			'struct_or_union' => 3,
			'declaration_specifiers' => 51,
			'compound_statement' => 132,
			'storage_class_specifier' => 36,
			'type_qualifier' => 28,
			'enum_specifier' => 29,
			'type_specifier' => 9,
			'struct_or_union_specifier' => 32
		}
	},
	{#State 54
		DEFAULT => -75
	},
	{#State 55
		DEFAULT => -83
	},
	{#State 56
		ACTIONS => {
			"," => 135,
			";" => 134
		}
	},
	{#State 57
		ACTIONS => {
			")" => 136
		}
	},
	{#State 58
		DEFAULT => -82
	},
	{#State 59
		ACTIONS => {
			"(" => 62,
			"[" => 61
		},
		DEFAULT => -130
	},
	{#State 60
		DEFAULT => -78
	},
	{#State 61
		ACTIONS => {
			"!" => 104,
			"-" => 115,
			"]" => 139,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			'IDENTIFIER' => 137,
			"&" => 80,
			'DEC_OP' => 89,
			"~" => 78,
			'CONSTANT' => 117,
			"*" => 119,
			'SIZEOF' => 105,
			"(" => 85,
			"+" => 127
		},
		GOTOS => {
			'exclusive_or_expression' => 109,
			'inclusive_or_expression' => 100,
			'logical_and_expression' => 110,
			'equality_expression' => 126,
			'logical_or_expression' => 81,
			'constant_expression' => 138,
			'and_expression' => 82,
			'cast_expression' => 83,
			'shift_expression' => 79,
			'relational_expression' => 106,
			'conditional_expression' => 140,
			'multiplicative_expression' => 122,
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'unary_expression' => 141,
			'additive_expression' => 91,
			'primary_expression' => 77
		}
	},
	{#State 62
		ACTIONS => {
			'EXTERN' => 31,
			'VOLATILE' => 7,
			'SIGNED' => 30,
			'INT' => 10,
			'TYPE_NAME' => 8,
			")" => 147,
			'REGISTER' => 1,
			'DOUBLE' => 2,
			'SHORT' => 4,
			'ENUM' => 5,
			'VOID' => 6,
			'TYPEDEF' => 21,
			'IDENTIFIER' => 142,
			'CONST' => 25,
			'UNION' => 14,
			'CHAR' => 13,
			'FLOAT' => 34,
			'STATIC' => 11,
			'LONG' => 20,
			'UNSIGNED' => 18,
			'AUTO' => 35,
			'STRUCT' => 19
		},
		GOTOS => {
			'struct_or_union_specifier' => 32,
			'type_specifier' => 9,
			'parameter_list' => 144,
			'type_qualifier' => 28,
			'enum_specifier' => 29,
			'storage_class_specifier' => 36,
			'declaration_specifiers' => 146,
			'struct_or_union' => 3,
			'parameter_declaration' => 143,
			'identifier_list' => 148,
			'parameter_type_list' => 145
		}
	},
	{#State 63
		ACTIONS => {
			'CHAR' => 13,
			'UNION' => 14,
			'FLOAT' => 34,
			'DOUBLE' => 2,
			'LONG' => 20,
			'SHORT' => 4,
			'ENUM' => 5,
			'VOID' => 6,
			'UNSIGNED' => 18,
			'STRUCT' => 19,
			'VOLATILE' => 7,
			'SIGNED' => 30,
			'INT' => 10,
			'CONST' => 25,
			'TYPE_NAME' => 8
		},
		GOTOS => {
			'struct_or_union' => 3,
			'struct_or_union_specifier' => 32,
			'specifier_qualifier_list' => 65,
			'struct_declaration_list' => 149,
			'type_specifier' => 66,
			'type_qualifier' => 68,
			'enum_specifier' => 29,
			'struct_declaration' => 64
		}
	},
	{#State 64
		DEFAULT => -109
	},
	{#State 65
		ACTIONS => {
			":" => 152,
			"*" => 17,
			"(" => 27,
			'IDENTIFIER' => 24
		},
		GOTOS => {
			'declarator' => 153,
			'direct_declarator' => 37,
			'pointer' => 33,
			'struct_declarator' => 151,
			'struct_declarator_list' => 150
		}
	},
	{#State 66
		ACTIONS => {
			'FLOAT' => 34,
			'UNION' => 14,
			'CHAR' => 13,
			'UNSIGNED' => 18,
			'STRUCT' => 19,
			'LONG' => 20,
			'CONST' => 25,
			'DOUBLE' => 2,
			'SHORT' => 4,
			'VOID' => 6,
			'ENUM' => 5,
			'VOLATILE' => 7,
			'SIGNED' => 30,
			'TYPE_NAME' => 8,
			'INT' => 10
		},
		DEFAULT => -113,
		GOTOS => {
			'specifier_qualifier_list' => 154,
			'struct_or_union_specifier' => 32,
			'struct_or_union' => 3,
			'type_specifier' => 66,
			'enum_specifier' => 29,
			'type_qualifier' => 68
		}
	},
	{#State 67
		ACTIONS => {
			'SHORT' => 4,
			'VOID' => 6,
			'ENUM' => 5,
			'DOUBLE' => 2,
			'INT' => 10,
			'TYPE_NAME' => 8,
			'VOLATILE' => 7,
			'SIGNED' => 30,
			'LONG' => 20,
			'UNSIGNED' => 18,
			'STRUCT' => 19,
			'CHAR' => 13,
			'UNION' => 14,
			'FLOAT' => 34,
			"}" => 156,
			'CONST' => 25
		},
		GOTOS => {
			'struct_or_union' => 3,
			'type_specifier' => 66,
			'specifier_qualifier_list' => 65,
			'struct_or_union_specifier' => 32,
			'struct_declaration' => 155,
			'enum_specifier' => 29,
			'type_qualifier' => 68
		}
	},
	{#State 68
		ACTIONS => {
			'DOUBLE' => 2,
			'ENUM' => 5,
			'VOID' => 6,
			'SHORT' => 4,
			'SIGNED' => 30,
			'VOLATILE' => 7,
			'INT' => 10,
			'TYPE_NAME' => 8,
			'CHAR' => 13,
			'UNION' => 14,
			'FLOAT' => 34,
			'LONG' => 20,
			'STRUCT' => 19,
			'UNSIGNED' => 18,
			'CONST' => 25
		},
		DEFAULT => -115,
		GOTOS => {
			'struct_or_union' => 3,
			'type_specifier' => 66,
			'specifier_qualifier_list' => 157,
			'struct_or_union_specifier' => 32,
			'type_qualifier' => 68,
			'enum_specifier' => 29
		}
	},
	{#State 69
		ACTIONS => {
			'IDENTIFIER' => 72
		},
		GOTOS => {
			'enumerator' => 71,
			'enumerator_list' => 158
		}
	},
	{#State 70
		ACTIONS => {
			"}" => 159,
			"," => 160
		}
	},
	{#State 71
		DEFAULT => -124
	},
	{#State 72
		ACTIONS => {
			"=" => 161
		},
		DEFAULT => -126
	},
	{#State 73
		DEFAULT => -142
	},
	{#State 74
		DEFAULT => -144
	},
	{#State 75
		ACTIONS => {
			'IDENTIFIER' => 162
		}
	},
	{#State 76
		ACTIONS => {
			'SIZEOF' => 105,
			"*" => 119,
			"{" => 50,
			'DEC_OP' => 89,
			'IDENTIFIER' => 88,
			'STRING_LITERAL' => 116,
			"!" => 104,
			'CONTINUE' => 114,
			"-" => 115,
			'DO' => 76,
			'CONSTANT' => 117,
			'GOTO' => 75,
			"~" => 78,
			'CASE' => 94,
			";" => 93,
			'DEFAULT' => 125,
			'BREAK' => 124,
			"(" => 85,
			'FOR' => 108,
			'WHILE' => 101,
			'IF' => 102,
			"+" => 127,
			'SWITCH' => 98,
			"&" => 80,
			'INC_OP' => 107,
			'RETURN' => 84
		},
		GOTOS => {
			'logical_or_expression' => 81,
			'selection_statement' => 123,
			'cast_expression' => 83,
			'statement' => 163,
			'and_expression' => 82,
			'inclusive_or_expression' => 100,
			'logical_and_expression' => 110,
			'jump_statement' => 86,
			'exclusive_or_expression' => 109,
			'expression_statement' => 111,
			'assignment_expression' => 112,
			'equality_expression' => 126,
			'unary_operator' => 90,
			'postfix_expression' => 103,
			'primary_expression' => 77,
			'additive_expression' => 91,
			'unary_expression' => 118,
			'compound_statement' => 92,
			'shift_expression' => 79,
			'iteration_statement' => 95,
			'expression' => 96,
			'conditional_expression' => 121,
			'multiplicative_expression' => 122,
			'labeled_statement' => 97,
			'relational_expression' => 106
		}
	},
	{#State 77
		DEFAULT => -5
	},
	{#State 78
		DEFAULT => -25
	},
	{#State 79
		ACTIONS => {
			'RIGHT_OP' => 164,
			'LEFT_OP' => 165
		},
		DEFAULT => -39
	},
	{#State 80
		DEFAULT => -21
	},
	{#State 81
		ACTIONS => {
			"?" => 167,
			'OR_OP' => 166
		},
		DEFAULT => -57
	},
	{#State 82
		ACTIONS => {
			"&" => 168
		},
		DEFAULT => -49
	},
	{#State 83
		DEFAULT => -29
	},
	{#State 84
		ACTIONS => {
			"+" => 127,
			"(" => 85,
			"*" => 119,
			'SIZEOF' => 105,
			'CONSTANT' => 117,
			";" => 170,
			"~" => 78,
			'IDENTIFIER' => 137,
			'DEC_OP' => 89,
			"&" => 80,
			"-" => 115,
			"!" => 104,
			'INC_OP' => 107,
			'STRING_LITERAL' => 116
		},
		GOTOS => {
			'exclusive_or_expression' => 109,
			'inclusive_or_expression' => 100,
			'logical_and_expression' => 110,
			'equality_expression' => 126,
			'assignment_expression' => 112,
			'logical_or_expression' => 81,
			'and_expression' => 82,
			'cast_expression' => 83,
			'shift_expression' => 79,
			'relational_expression' => 106,
			'expression' => 169,
			'multiplicative_expression' => 122,
			'conditional_expression' => 121,
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'unary_expression' => 118,
			'additive_expression' => 91,
			'primary_expression' => 77
		}
	},
	{#State 85
		ACTIONS => {
			'VOLATILE' => 7,
			'SIGNED' => 30,
			"&" => 80,
			'INT' => 10,
			'TYPE_NAME' => 8,
			'INC_OP' => 107,
			"+" => 127,
			'DOUBLE' => 2,
			'SHORT' => 4,
			'VOID' => 6,
			'ENUM' => 5,
			"(" => 85,
			'CONSTANT' => 117,
			"~" => 78,
			'IDENTIFIER' => 137,
			'CONST' => 25,
			'DEC_OP' => 89,
			"!" => 104,
			"-" => 115,
			'STRING_LITERAL' => 116,
			'CHAR' => 13,
			'UNION' => 14,
			'FLOAT' => 34,
			'LONG' => 20,
			'UNSIGNED' => 18,
			"*" => 119,
			'STRUCT' => 19,
			'SIZEOF' => 105
		},
		GOTOS => {
			'equality_expression' => 126,
			'assignment_expression' => 112,
			'struct_or_union' => 3,
			'exclusive_or_expression' => 109,
			'inclusive_or_expression' => 100,
			'type_name' => 173,
			'logical_and_expression' => 110,
			'and_expression' => 82,
			'cast_expression' => 83,
			'type_qualifier' => 68,
			'enum_specifier' => 29,
			'type_specifier' => 66,
			'struct_or_union_specifier' => 32,
			'specifier_qualifier_list' => 172,
			'logical_or_expression' => 81,
			'relational_expression' => 106,
			'expression' => 171,
			'conditional_expression' => 121,
			'multiplicative_expression' => 122,
			'shift_expression' => 79,
			'additive_expression' => 91,
			'unary_expression' => 118,
			'primary_expression' => 77,
			'postfix_expression' => 103,
			'unary_operator' => 90
		}
	},
	{#State 86
		DEFAULT => -178
	},
	{#State 87
		ACTIONS => {
			'WHILE' => 101,
			'SHORT' => 4,
			'DEFAULT' => 125,
			'VOID' => 6,
			'ENUM' => 5,
			'BREAK' => 124,
			"+" => 127,
			'REGISTER' => 1,
			'DOUBLE' => 2,
			'IF' => 102,
			'TYPE_NAME' => 8,
			'INT' => 10,
			'SWITCH' => 98,
			'VOLATILE' => 7,
			'UNSIGNED' => 18,
			"*" => 119,
			'STRUCT' => 19,
			'LONG' => 20,
			'STATIC' => 11,
			'UNION' => 14,
			'CHAR' => 13,
			'CONTINUE' => 114,
			"-" => 115,
			'STRING_LITERAL' => 116,
			"}" => 175,
			'IDENTIFIER' => 88,
			'CONST' => 25,
			'DEC_OP' => 89,
			'TYPEDEF' => 21,
			";" => 93,
			'CASE' => 94,
			'CONSTANT' => 117,
			'FOR' => 108,
			"(" => 85,
			'INC_OP' => 107,
			"&" => 80,
			'RETURN' => 84,
			'SIGNED' => 30,
			'EXTERN' => 31,
			'AUTO' => 35,
			'SIZEOF' => 105,
			'FLOAT' => 34,
			"{" => 50,
			"!" => 104,
			"~" => 78,
			'GOTO' => 75,
			'DO' => 76
		},
		GOTOS => {
			'inclusive_or_expression' => 100,
			'struct_or_union' => 3,
			'equality_expression' => 126,
			'selection_statement' => 123,
			'type_specifier' => 9,
			'statement' => 99,
			'iteration_statement' => 95,
			'statement_list' => 174,
			'expression' => 96,
			'declaration' => 130,
			'multiplicative_expression' => 122,
			'conditional_expression' => 121,
			'labeled_statement' => 97,
			'unary_operator' => 90,
			'unary_expression' => 118,
			'additive_expression' => 91,
			'compound_statement' => 92,
			'declaration_specifiers' => 51,
			'jump_statement' => 86,
			'logical_and_expression' => 110,
			'exclusive_or_expression' => 109,
			'expression_statement' => 111,
			'assignment_expression' => 112,
			'struct_or_union_specifier' => 32,
			'logical_or_expression' => 81,
			'cast_expression' => 83,
			'enum_specifier' => 29,
			'type_qualifier' => 28,
			'and_expression' => 82,
			'shift_expression' => 79,
			'relational_expression' => 106,
			'postfix_expression' => 103,
			'primary_expression' => 77,
			'storage_class_specifier' => 36
		}
	},
	{#State 88
		ACTIONS => {
			":" => 176
		},
		DEFAULT => -1
	},
	{#State 89
		ACTIONS => {
			"+" => 127,
			"*" => 119,
			'SIZEOF' => 105,
			"(" => 178,
			"~" => 78,
			'CONSTANT' => 117,
			"!" => 104,
			"-" => 115,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			'IDENTIFIER' => 137,
			'DEC_OP' => 89,
			"&" => 80
		},
		GOTOS => {
			'unary_operator' => 90,
			'postfix_expression' => 103,
			'primary_expression' => 77,
			'unary_expression' => 177
		}
	},
	{#State 90
		ACTIONS => {
			"(" => 85,
			'SIZEOF' => 105,
			"*" => 119,
			"+" => 127,
			'DEC_OP' => 89,
			"&" => 80,
			'IDENTIFIER' => 137,
			'INC_OP' => 107,
			'STRING_LITERAL' => 116,
			"-" => 115,
			"!" => 104,
			'CONSTANT' => 117,
			"~" => 78
		},
		GOTOS => {
			'cast_expression' => 179,
			'primary_expression' => 77,
			'unary_expression' => 141,
			'unary_operator' => 90,
			'postfix_expression' => 103
		}
	},
	{#State 91
		ACTIONS => {
			"-" => 181,
			"+" => 180
		},
		DEFAULT => -36
	},
	{#State 92
		DEFAULT => -174
	},
	{#State 93
		DEFAULT => -190
	},
	{#State 94
		ACTIONS => {
			"!" => 104,
			"-" => 115,
			'INC_OP' => 107,
			'STRING_LITERAL' => 116,
			'IDENTIFIER' => 137,
			'DEC_OP' => 89,
			"&" => 80,
			"~" => 78,
			'CONSTANT' => 117,
			"*" => 119,
			'SIZEOF' => 105,
			"(" => 85,
			"+" => 127
		},
		GOTOS => {
			'unary_operator' => 90,
			'postfix_expression' => 103,
			'primary_expression' => 77,
			'unary_expression' => 141,
			'additive_expression' => 91,
			'shift_expression' => 79,
			'multiplicative_expression' => 122,
			'conditional_expression' => 140,
			'relational_expression' => 106,
			'constant_expression' => 182,
			'logical_or_expression' => 81,
			'cast_expression' => 83,
			'and_expression' => 82,
			'inclusive_or_expression' => 100,
			'logical_and_expression' => 110,
			'exclusive_or_expression' => 109,
			'equality_expression' => 126
		}
	},
	{#State 95
		DEFAULT => -177
	},
	{#State 96
		ACTIONS => {
			"," => 183,
			";" => 184
		}
	},
	{#State 97
		DEFAULT => -173
	},
	{#State 98
		ACTIONS => {
			"(" => 185
		}
	},
	{#State 99
		DEFAULT => -188
	},
	{#State 100
		ACTIONS => {
			"|" => 186
		},
		DEFAULT => -53
	},
	{#State 101
		ACTIONS => {
			"(" => 187
		}
	},
	{#State 102
		ACTIONS => {
			"(" => 188
		}
	},
	{#State 103
		ACTIONS => {
			'PTR_OP' => 189,
			'INC_OP' => 190,
			"(" => 192,
			'DEC_OP' => 193,
			"." => 191,
			"[" => 194
		},
		DEFAULT => -15
	},
	{#State 104
		DEFAULT => -26
	},
	{#State 105
		ACTIONS => {
			"*" => 119,
			'SIZEOF' => 105,
			"(" => 196,
			"+" => 127,
			"!" => 104,
			"-" => 115,
			'INC_OP' => 107,
			'STRING_LITERAL' => 116,
			'IDENTIFIER' => 137,
			"&" => 80,
			'DEC_OP' => 89,
			"~" => 78,
			'CONSTANT' => 117
		},
		GOTOS => {
			'unary_operator' => 90,
			'postfix_expression' => 103,
			'primary_expression' => 77,
			'unary_expression' => 195
		}
	},
	{#State 106
		ACTIONS => {
			'LE_OP' => 197,
			'GE_OP' => 200,
			"<" => 198,
			">" => 199
		},
		DEFAULT => -44
	},
	{#State 107
		ACTIONS => {
			'SIZEOF' => 105,
			"*" => 119,
			"(" => 178,
			"+" => 127,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			"!" => 104,
			"-" => 115,
			"&" => 80,
			'DEC_OP' => 89,
			'IDENTIFIER' => 137,
			"~" => 78,
			'CONSTANT' => 117
		},
		GOTOS => {
			'unary_expression' => 201,
			'primary_expression' => 77,
			'postfix_expression' => 103,
			'unary_operator' => 90
		}
	},
	{#State 108
		ACTIONS => {
			"(" => 202
		}
	},
	{#State 109
		ACTIONS => {
			"^" => 203
		},
		DEFAULT => -51
	},
	{#State 110
		ACTIONS => {
			'AND_OP' => 204
		},
		DEFAULT => -55
	},
	{#State 111
		DEFAULT => -175
	},
	{#State 112
		DEFAULT => -72
	},
	{#State 113
		DEFAULT => -182
	},
	{#State 114
		ACTIONS => {
			";" => 205
		}
	},
	{#State 115
		DEFAULT => -24
	},
	{#State 116
		DEFAULT => -3
	},
	{#State 117
		DEFAULT => -2
	},
	{#State 118
		ACTIONS => {
			"=" => 207,
			'OR_ASSIGN' => 208,
			'ADD_ASSIGN' => 216,
			'MUL_ASSIGN' => 214,
			'LEFT_ASSIGN' => 206,
			'SUB_ASSIGN' => 213,
			'DIV_ASSIGN' => 212,
			'AND_ASSIGN' => 217,
			'XOR_ASSIGN' => 211,
			'MOD_ASSIGN' => 209,
			'RIGHT_ASSIGN' => 210
		},
		DEFAULT => -27,
		GOTOS => {
			'assignment_operator' => 215
		}
	},
	{#State 119
		DEFAULT => -22
	},
	{#State 120
		ACTIONS => {
			'RETURN' => 84,
			'SWITCH' => 98,
			"&" => 80,
			'INC_OP' => 107,
			'IF' => 102,
			"+" => 127,
			'FOR' => 108,
			'BREAK' => 124,
			"(" => 85,
			'DEFAULT' => 125,
			'WHILE' => 101,
			'GOTO' => 75,
			'DO' => 76,
			'CONSTANT' => 117,
			";" => 93,
			'CASE' => 94,
			"~" => 78,
			'IDENTIFIER' => 88,
			"}" => 218,
			'DEC_OP' => 89,
			"-" => 115,
			'CONTINUE' => 114,
			"!" => 104,
			'STRING_LITERAL' => 116,
			"{" => 50,
			"*" => 119,
			'SIZEOF' => 105
		},
		GOTOS => {
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'compound_statement' => 92,
			'unary_expression' => 118,
			'additive_expression' => 91,
			'primary_expression' => 77,
			'shift_expression' => 79,
			'iteration_statement' => 95,
			'relational_expression' => 106,
			'expression' => 96,
			'conditional_expression' => 121,
			'multiplicative_expression' => 122,
			'labeled_statement' => 97,
			'selection_statement' => 123,
			'logical_or_expression' => 81,
			'and_expression' => 82,
			'cast_expression' => 83,
			'statement' => 219,
			'exclusive_or_expression' => 109,
			'inclusive_or_expression' => 100,
			'jump_statement' => 86,
			'logical_and_expression' => 110,
			'equality_expression' => 126,
			'assignment_expression' => 112,
			'expression_statement' => 111
		}
	},
	{#State 121
		DEFAULT => -59
	},
	{#State 122
		ACTIONS => {
			"*" => 220,
			"/" => 222,
			"%" => 221
		},
		DEFAULT => -33
	},
	{#State 123
		DEFAULT => -176
	},
	{#State 124
		ACTIONS => {
			";" => 223
		}
	},
	{#State 125
		ACTIONS => {
			":" => 224
		}
	},
	{#State 126
		ACTIONS => {
			'EQ_OP' => 225,
			'NE_OP' => 226
		},
		DEFAULT => -47
	},
	{#State 127
		DEFAULT => -23
	},
	{#State 128
		ACTIONS => {
			"=" => 133
		},
		DEFAULT => -85
	},
	{#State 129
		DEFAULT => -210
	},
	{#State 130
		DEFAULT => -187
	},
	{#State 131
		ACTIONS => {
			'TYPE_NAME' => 8,
			'INT' => 10,
			'VOLATILE' => 7,
			'SIGNED' => 30,
			'EXTERN' => 31,
			'SHORT' => 4,
			'ENUM' => 5,
			'VOID' => 6,
			'REGISTER' => 1,
			'DOUBLE' => 2,
			'CONST' => 25,
			'TYPEDEF' => 21,
			'UNSIGNED' => 18,
			'AUTO' => 35,
			'STRUCT' => 19,
			'LONG' => 20,
			'FLOAT' => 34,
			'STATIC' => 11,
			"{" => 50,
			'UNION' => 14,
			'CHAR' => 13
		},
		GOTOS => {
			'struct_or_union' => 3,
			'declaration_specifiers' => 51,
			'declaration' => 130,
			'type_specifier' => 9,
			'struct_or_union_specifier' => 32,
			'storage_class_specifier' => 36,
			'compound_statement' => 227,
			'type_qualifier' => 28,
			'enum_specifier' => 29
		}
	},
	{#State 132
		DEFAULT => -209
	},
	{#State 133
		ACTIONS => {
			"*" => 119,
			'SIZEOF' => 105,
			"(" => 85,
			"+" => 127,
			"{" => 229,
			"-" => 115,
			"!" => 104,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			'IDENTIFIER' => 137,
			"&" => 80,
			'DEC_OP' => 89,
			"~" => 78,
			'CONSTANT' => 117
		},
		GOTOS => {
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'initializer' => 228,
			'unary_expression' => 118,
			'additive_expression' => 91,
			'primary_expression' => 77,
			'shift_expression' => 79,
			'relational_expression' => 106,
			'multiplicative_expression' => 122,
			'conditional_expression' => 121,
			'logical_or_expression' => 81,
			'and_expression' => 82,
			'cast_expression' => 83,
			'exclusive_or_expression' => 109,
			'logical_and_expression' => 110,
			'inclusive_or_expression' => 100,
			'equality_expression' => 126,
			'assignment_expression' => 230
		}
	},
	{#State 134
		DEFAULT => -76
	},
	{#State 135
		ACTIONS => {
			"(" => 27,
			'IDENTIFIER' => 24,
			"*" => 17
		},
		GOTOS => {
			'direct_declarator' => 37,
			'declarator' => 128,
			'init_declarator' => 231,
			'pointer' => 33
		}
	},
	{#State 136
		DEFAULT => -133
	},
	{#State 137
		DEFAULT => -1
	},
	{#State 138
		ACTIONS => {
			"]" => 232
		}
	},
	{#State 139
		DEFAULT => -135
	},
	{#State 140
		DEFAULT => -74
	},
	{#State 141
		DEFAULT => -27
	},
	{#State 142
		DEFAULT => -152
	},
	{#State 143
		DEFAULT => -147
	},
	{#State 144
		ACTIONS => {
			"," => 233
		},
		DEFAULT => -145
	},
	{#State 145
		ACTIONS => {
			")" => 234
		}
	},
	{#State 146
		ACTIONS => {
			"[" => 238,
			"*" => 17,
			"(" => 239,
			'IDENTIFIER' => 24
		},
		DEFAULT => -151,
		GOTOS => {
			'pointer' => 240,
			'abstract_declarator' => 237,
			'direct_declarator' => 37,
			'direct_abstract_declarator' => 236,
			'declarator' => 235
		}
	},
	{#State 147
		DEFAULT => -138
	},
	{#State 148
		ACTIONS => {
			")" => 242,
			"," => 241
		}
	},
	{#State 149
		ACTIONS => {
			"}" => 243,
			'CONST' => 25,
			'UNSIGNED' => 18,
			'STRUCT' => 19,
			'LONG' => 20,
			'FLOAT' => 34,
			'UNION' => 14,
			'CHAR' => 13,
			'TYPE_NAME' => 8,
			'INT' => 10,
			'VOLATILE' => 7,
			'SIGNED' => 30,
			'SHORT' => 4,
			'VOID' => 6,
			'ENUM' => 5,
			'DOUBLE' => 2
		},
		GOTOS => {
			'struct_declaration' => 155,
			'type_qualifier' => 68,
			'enum_specifier' => 29,
			'type_specifier' => 66,
			'struct_or_union' => 3,
			'struct_or_union_specifier' => 32,
			'specifier_qualifier_list' => 65
		}
	},
	{#State 150
		ACTIONS => {
			"," => 245,
			";" => 244
		}
	},
	{#State 151
		DEFAULT => -116
	},
	{#State 152
		ACTIONS => {
			'SIZEOF' => 105,
			"*" => 119,
			"(" => 85,
			"+" => 127,
			'INC_OP' => 107,
			'STRING_LITERAL' => 116,
			"!" => 104,
			"-" => 115,
			"&" => 80,
			'DEC_OP' => 89,
			'IDENTIFIER' => 137,
			"~" => 78,
			'CONSTANT' => 117
		},
		GOTOS => {
			'shift_expression' => 79,
			'relational_expression' => 106,
			'multiplicative_expression' => 122,
			'conditional_expression' => 140,
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'unary_expression' => 141,
			'additive_expression' => 91,
			'primary_expression' => 77,
			'exclusive_or_expression' => 109,
			'inclusive_or_expression' => 100,
			'logical_and_expression' => 110,
			'equality_expression' => 126,
			'logical_or_expression' => 81,
			'constant_expression' => 246,
			'and_expression' => 82,
			'cast_expression' => 83
		}
	},
	{#State 153
		ACTIONS => {
			":" => 247
		},
		DEFAULT => -118
	},
	{#State 154
		DEFAULT => -112
	},
	{#State 155
		DEFAULT => -110
	},
	{#State 156
		DEFAULT => -105
	},
	{#State 157
		DEFAULT => -114
	},
	{#State 158
		ACTIONS => {
			"}" => 248,
			"," => 160
		}
	},
	{#State 159
		DEFAULT => -121
	},
	{#State 160
		ACTIONS => {
			'IDENTIFIER' => 72
		},
		GOTOS => {
			'enumerator' => 249
		}
	},
	{#State 161
		ACTIONS => {
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			"-" => 115,
			"!" => 104,
			"&" => 80,
			'DEC_OP' => 89,
			'IDENTIFIER' => 137,
			"~" => 78,
			'CONSTANT' => 117,
			'SIZEOF' => 105,
			"*" => 119,
			"(" => 85,
			"+" => 127
		},
		GOTOS => {
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'additive_expression' => 91,
			'unary_expression' => 141,
			'primary_expression' => 77,
			'shift_expression' => 79,
			'relational_expression' => 106,
			'multiplicative_expression' => 122,
			'conditional_expression' => 140,
			'constant_expression' => 250,
			'logical_or_expression' => 81,
			'and_expression' => 82,
			'cast_expression' => 83,
			'exclusive_or_expression' => 109,
			'inclusive_or_expression' => 100,
			'logical_and_expression' => 110,
			'equality_expression' => 126
		}
	},
	{#State 162
		ACTIONS => {
			";" => 251
		}
	},
	{#State 163
		ACTIONS => {
			'WHILE' => 252
		}
	},
	{#State 164
		ACTIONS => {
			"~" => 78,
			'CONSTANT' => 117,
			"!" => 104,
			"-" => 115,
			'INC_OP' => 107,
			'STRING_LITERAL' => 116,
			'IDENTIFIER' => 137,
			"&" => 80,
			'DEC_OP' => 89,
			"+" => 127,
			"*" => 119,
			'SIZEOF' => 105,
			"(" => 85
		},
		GOTOS => {
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'unary_expression' => 141,
			'additive_expression' => 253,
			'multiplicative_expression' => 122,
			'primary_expression' => 77,
			'cast_expression' => 83
		}
	},
	{#State 165
		ACTIONS => {
			"*" => 119,
			'SIZEOF' => 105,
			"(" => 85,
			"+" => 127,
			"-" => 115,
			"!" => 104,
			'INC_OP' => 107,
			'STRING_LITERAL' => 116,
			'IDENTIFIER' => 137,
			"&" => 80,
			'DEC_OP' => 89,
			"~" => 78,
			'CONSTANT' => 117
		},
		GOTOS => {
			'cast_expression' => 83,
			'primary_expression' => 77,
			'multiplicative_expression' => 122,
			'additive_expression' => 254,
			'unary_expression' => 141,
			'unary_operator' => 90,
			'postfix_expression' => 103
		}
	},
	{#State 166
		ACTIONS => {
			"(" => 85,
			"*" => 119,
			'SIZEOF' => 105,
			"+" => 127,
			'IDENTIFIER' => 137,
			"&" => 80,
			'DEC_OP' => 89,
			"-" => 115,
			"!" => 104,
			'INC_OP' => 107,
			'STRING_LITERAL' => 116,
			'CONSTANT' => 117,
			"~" => 78
		},
		GOTOS => {
			'exclusive_or_expression' => 109,
			'shift_expression' => 79,
			'logical_and_expression' => 255,
			'inclusive_or_expression' => 100,
			'relational_expression' => 106,
			'equality_expression' => 126,
			'multiplicative_expression' => 122,
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'unary_expression' => 141,
			'additive_expression' => 91,
			'and_expression' => 82,
			'cast_expression' => 83,
			'primary_expression' => 77
		}
	},
	{#State 167
		ACTIONS => {
			"-" => 115,
			"!" => 104,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			'IDENTIFIER' => 137,
			'DEC_OP' => 89,
			"&" => 80,
			"~" => 78,
			'CONSTANT' => 117,
			"*" => 119,
			'SIZEOF' => 105,
			"(" => 85,
			"+" => 127
		},
		GOTOS => {
			'logical_or_expression' => 81,
			'and_expression' => 82,
			'cast_expression' => 83,
			'exclusive_or_expression' => 109,
			'logical_and_expression' => 110,
			'inclusive_or_expression' => 100,
			'equality_expression' => 126,
			'assignment_expression' => 112,
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'additive_expression' => 91,
			'unary_expression' => 118,
			'primary_expression' => 77,
			'shift_expression' => 79,
			'relational_expression' => 106,
			'conditional_expression' => 121,
			'multiplicative_expression' => 122,
			'expression' => 256
		}
	},
	{#State 168
		ACTIONS => {
			"~" => 78,
			'CONSTANT' => 117,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			"-" => 115,
			"!" => 104,
			'DEC_OP' => 89,
			"&" => 80,
			'IDENTIFIER' => 137,
			"+" => 127,
			'SIZEOF' => 105,
			"*" => 119,
			"(" => 85
		},
		GOTOS => {
			'multiplicative_expression' => 122,
			'relational_expression' => 106,
			'equality_expression' => 257,
			'shift_expression' => 79,
			'cast_expression' => 83,
			'primary_expression' => 77,
			'additive_expression' => 91,
			'unary_expression' => 141,
			'unary_operator' => 90,
			'postfix_expression' => 103
		}
	},
	{#State 169
		ACTIONS => {
			";" => 258,
			"," => 183
		}
	},
	{#State 170
		DEFAULT => -202
	},
	{#State 171
		ACTIONS => {
			"," => 183,
			")" => 259
		}
	},
	{#State 172
		ACTIONS => {
			"(" => 262,
			"*" => 17,
			"[" => 238
		},
		DEFAULT => -154,
		GOTOS => {
			'pointer' => 261,
			'abstract_declarator' => 260,
			'direct_abstract_declarator' => 236
		}
	},
	{#State 173
		ACTIONS => {
			")" => 263
		}
	},
	{#State 174
		ACTIONS => {
			"*" => 119,
			'SIZEOF' => 105,
			"{" => 50,
			"}" => 264,
			'IDENTIFIER' => 88,
			'DEC_OP' => 89,
			"-" => 115,
			'CONTINUE' => 114,
			"!" => 104,
			'STRING_LITERAL' => 116,
			'GOTO' => 75,
			'CONSTANT' => 117,
			'DO' => 76,
			";" => 93,
			"~" => 78,
			'CASE' => 94,
			'FOR' => 108,
			'DEFAULT' => 125,
			"(" => 85,
			'BREAK' => 124,
			'WHILE' => 101,
			'IF' => 102,
			"+" => 127,
			"&" => 80,
			'SWITCH' => 98,
			'INC_OP' => 107,
			'RETURN' => 84
		},
		GOTOS => {
			'expression' => 96,
			'conditional_expression' => 121,
			'labeled_statement' => 97,
			'multiplicative_expression' => 122,
			'relational_expression' => 106,
			'shift_expression' => 79,
			'iteration_statement' => 95,
			'primary_expression' => 77,
			'unary_expression' => 118,
			'additive_expression' => 91,
			'compound_statement' => 92,
			'unary_operator' => 90,
			'postfix_expression' => 103,
			'assignment_expression' => 112,
			'expression_statement' => 111,
			'equality_expression' => 126,
			'inclusive_or_expression' => 100,
			'logical_and_expression' => 110,
			'jump_statement' => 86,
			'exclusive_or_expression' => 109,
			'cast_expression' => 83,
			'statement' => 219,
			'and_expression' => 82,
			'selection_statement' => 123,
			'logical_or_expression' => 81
		}
	},
	{#State 175
		DEFAULT => -184
	},
	{#State 176
		ACTIONS => {
			"&" => 80,
			'SWITCH' => 98,
			'INC_OP' => 107,
			'RETURN' => 84,
			"(" => 85,
			'BREAK' => 124,
			'DEFAULT' => 125,
			'FOR' => 108,
			'WHILE' => 101,
			'IF' => 102,
			"+" => 127,
			'DEC_OP' => 89,
			'IDENTIFIER' => 88,
			'STRING_LITERAL' => 116,
			'CONTINUE' => 114,
			"-" => 115,
			"!" => 104,
			'DO' => 76,
			'CONSTANT' => 117,
			'GOTO' => 75,
			'CASE' => 94,
			"~" => 78,
			";" => 93,
			'SIZEOF' => 105,
			"*" => 119,
			"{" => 50
		},
		GOTOS => {
			'inclusive_or_expression' => 100,
			'logical_and_expression' => 110,
			'jump_statement' => 86,
			'exclusive_or_expression' => 109,
			'assignment_expression' => 112,
			'expression_statement' => 111,
			'equality_expression' => 126,
			'logical_or_expression' => 81,
			'selection_statement' => 123,
			'cast_expression' => 83,
			'statement' => 265,
			'and_expression' => 82,
			'shift_expression' => 79,
			'iteration_statement' => 95,
			'expression' => 96,
			'multiplicative_expression' => 122,
			'labeled_statement' => 97,
			'conditional_expression' => 121,
			'relational_expression' => 106,
			'unary_operator' => 90,
			'postfix_expression' => 103,
			'primary_expression' => 77,
			'compound_statement' => 92,
			'unary_expression' => 118,
			'additive_expression' => 91
		}
	},
	{#State 177
		DEFAULT => -17
	},
	{#State 178
		ACTIONS => {
			"-" => 115,
			"!" => 104,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			'IDENTIFIER' => 137,
			'DEC_OP' => 89,
			"&" => 80,
			"~" => 78,
			'CONSTANT' => 117,
			"*" => 119,
			'SIZEOF' => 105,
			"(" => 85,
			"+" => 127
		},
		GOTOS => {
			'shift_expression' => 79,
			'conditional_expression' => 121,
			'multiplicative_expression' => 122,
			'expression' => 171,
			'relational_expression' => 106,
			'unary_operator' => 90,
			'postfix_expression' => 103,
			'primary_expression' => 77,
			'unary_expression' => 118,
			'additive_expression' => 91,
			'logical_and_expression' => 110,
			'inclusive_or_expression' => 100,
			'exclusive_or_expression' => 109,
			'assignment_expression' => 112,
			'equality_expression' => 126,
			'logical_or_expression' => 81,
			'cast_expression' => 83,
			'and_expression' => 82
		}
	},
	{#State 179
		DEFAULT => -18
	},
	{#State 180
		ACTIONS => {
			'CONSTANT' => 117,
			"~" => 78,
			'IDENTIFIER' => 137,
			'DEC_OP' => 89,
			"&" => 80,
			"-" => 115,
			"!" => 104,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			"+" => 127,
			"(" => 85,
			"*" => 119,
			'SIZEOF' => 105
		},
		GOTOS => {
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'unary_expression' => 141,
			'multiplicative_expression' => 266,
			'primary_expression' => 77,
			'cast_expression' => 83
		}
	},
	{#State 181
		ACTIONS => {
			"~" => 78,
			'CONSTANT' => 117,
			"!" => 104,
			"-" => 115,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			'IDENTIFIER' => 137,
			'DEC_OP' => 89,
			"&" => 80,
			"+" => 127,
			"*" => 119,
			'SIZEOF' => 105,
			"(" => 85
		},
		GOTOS => {
			'unary_expression' => 141,
			'primary_expression' => 77,
			'cast_expression' => 83,
			'multiplicative_expression' => 267,
			'postfix_expression' => 103,
			'unary_operator' => 90
		}
	},
	{#State 182
		ACTIONS => {
			":" => 268
		}
	},
	{#State 183
		ACTIONS => {
			"+" => 127,
			"*" => 119,
			'SIZEOF' => 105,
			"(" => 85,
			"~" => 78,
			'CONSTANT' => 117,
			"-" => 115,
			"!" => 104,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			'IDENTIFIER' => 137,
			'DEC_OP' => 89,
			"&" => 80
		},
		GOTOS => {
			'shift_expression' => 79,
			'relational_expression' => 106,
			'conditional_expression' => 121,
			'multiplicative_expression' => 122,
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'additive_expression' => 91,
			'unary_expression' => 118,
			'primary_expression' => 77,
			'exclusive_or_expression' => 109,
			'logical_and_expression' => 110,
			'inclusive_or_expression' => 100,
			'equality_expression' => 126,
			'assignment_expression' => 269,
			'logical_or_expression' => 81,
			'and_expression' => 82,
			'cast_expression' => 83
		}
	},
	{#State 184
		DEFAULT => -191
	},
	{#State 185
		ACTIONS => {
			"+" => 127,
			'SIZEOF' => 105,
			"*" => 119,
			"(" => 85,
			"~" => 78,
			'CONSTANT' => 117,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			"-" => 115,
			"!" => 104,
			"&" => 80,
			'DEC_OP' => 89,
			'IDENTIFIER' => 137
		},
		GOTOS => {
			'assignment_expression' => 112,
			'equality_expression' => 126,
			'inclusive_or_expression' => 100,
			'logical_and_expression' => 110,
			'exclusive_or_expression' => 109,
			'cast_expression' => 83,
			'and_expression' => 82,
			'logical_or_expression' => 81,
			'expression' => 270,
			'multiplicative_expression' => 122,
			'conditional_expression' => 121,
			'relational_expression' => 106,
			'shift_expression' => 79,
			'primary_expression' => 77,
			'additive_expression' => 91,
			'unary_expression' => 118,
			'unary_operator' => 90,
			'postfix_expression' => 103
		}
	},
	{#State 186
		ACTIONS => {
			'DEC_OP' => 89,
			"&" => 80,
			'IDENTIFIER' => 137,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			"!" => 104,
			"-" => 115,
			'CONSTANT' => 117,
			"~" => 78,
			"(" => 85,
			'SIZEOF' => 105,
			"*" => 119,
			"+" => 127
		},
		GOTOS => {
			'unary_expression' => 141,
			'additive_expression' => 91,
			'and_expression' => 82,
			'cast_expression' => 83,
			'primary_expression' => 77,
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'relational_expression' => 106,
			'equality_expression' => 126,
			'multiplicative_expression' => 122,
			'exclusive_or_expression' => 271,
			'shift_expression' => 79
		}
	},
	{#State 187
		ACTIONS => {
			"*" => 119,
			'SIZEOF' => 105,
			"(" => 85,
			"+" => 127,
			"!" => 104,
			"-" => 115,
			'INC_OP' => 107,
			'STRING_LITERAL' => 116,
			'IDENTIFIER' => 137,
			"&" => 80,
			'DEC_OP' => 89,
			"~" => 78,
			'CONSTANT' => 117
		},
		GOTOS => {
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'additive_expression' => 91,
			'unary_expression' => 118,
			'primary_expression' => 77,
			'shift_expression' => 79,
			'relational_expression' => 106,
			'multiplicative_expression' => 122,
			'conditional_expression' => 121,
			'expression' => 272,
			'logical_or_expression' => 81,
			'and_expression' => 82,
			'cast_expression' => 83,
			'exclusive_or_expression' => 109,
			'logical_and_expression' => 110,
			'inclusive_or_expression' => 100,
			'equality_expression' => 126,
			'assignment_expression' => 112
		}
	},
	{#State 188
		ACTIONS => {
			"-" => 115,
			"!" => 104,
			'INC_OP' => 107,
			'STRING_LITERAL' => 116,
			'IDENTIFIER' => 137,
			"&" => 80,
			'DEC_OP' => 89,
			"~" => 78,
			'CONSTANT' => 117,
			"*" => 119,
			'SIZEOF' => 105,
			"(" => 85,
			"+" => 127
		},
		GOTOS => {
			'logical_or_expression' => 81,
			'and_expression' => 82,
			'cast_expression' => 83,
			'exclusive_or_expression' => 109,
			'logical_and_expression' => 110,
			'inclusive_or_expression' => 100,
			'equality_expression' => 126,
			'assignment_expression' => 112,
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'additive_expression' => 91,
			'unary_expression' => 118,
			'primary_expression' => 77,
			'shift_expression' => 79,
			'relational_expression' => 106,
			'conditional_expression' => 121,
			'multiplicative_expression' => 122,
			'expression' => 273
		}
	},
	{#State 189
		ACTIONS => {
			'IDENTIFIER' => 274
		}
	},
	{#State 190
		DEFAULT => -11
	},
	{#State 191
		ACTIONS => {
			'IDENTIFIER' => 275
		}
	},
	{#State 192
		ACTIONS => {
			"(" => 85,
			"*" => 119,
			'SIZEOF' => 105,
			")" => 276,
			"+" => 127,
			'IDENTIFIER' => 137,
			'DEC_OP' => 89,
			"&" => 80,
			"-" => 115,
			"!" => 104,
			'INC_OP' => 107,
			'STRING_LITERAL' => 116,
			'CONSTANT' => 117,
			"~" => 78
		},
		GOTOS => {
			'equality_expression' => 126,
			'assignment_expression' => 277,
			'exclusive_or_expression' => 109,
			'inclusive_or_expression' => 100,
			'logical_and_expression' => 110,
			'and_expression' => 82,
			'cast_expression' => 83,
			'logical_or_expression' => 81,
			'relational_expression' => 106,
			'multiplicative_expression' => 122,
			'conditional_expression' => 121,
			'argument_expression_list' => 278,
			'shift_expression' => 79,
			'unary_expression' => 118,
			'additive_expression' => 91,
			'primary_expression' => 77,
			'postfix_expression' => 103,
			'unary_operator' => 90
		}
	},
	{#State 193
		DEFAULT => -12
	},
	{#State 194
		ACTIONS => {
			'SIZEOF' => 105,
			"*" => 119,
			"(" => 85,
			"+" => 127,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			"-" => 115,
			"!" => 104,
			'DEC_OP' => 89,
			"&" => 80,
			'IDENTIFIER' => 137,
			"~" => 78,
			'CONSTANT' => 117
		},
		GOTOS => {
			'equality_expression' => 126,
			'assignment_expression' => 112,
			'exclusive_or_expression' => 109,
			'logical_and_expression' => 110,
			'inclusive_or_expression' => 100,
			'and_expression' => 82,
			'cast_expression' => 83,
			'logical_or_expression' => 81,
			'relational_expression' => 106,
			'multiplicative_expression' => 122,
			'conditional_expression' => 121,
			'expression' => 279,
			'shift_expression' => 79,
			'unary_expression' => 118,
			'additive_expression' => 91,
			'primary_expression' => 77,
			'postfix_expression' => 103,
			'unary_operator' => 90
		}
	},
	{#State 195
		DEFAULT => -19
	},
	{#State 196
		ACTIONS => {
			'VOLATILE' => 7,
			'SIGNED' => 30,
			'INT' => 10,
			"&" => 80,
			'TYPE_NAME' => 8,
			'INC_OP' => 107,
			"+" => 127,
			'DOUBLE' => 2,
			'SHORT' => 4,
			'ENUM' => 5,
			'VOID' => 6,
			"(" => 85,
			'CONSTANT' => 117,
			"~" => 78,
			'IDENTIFIER' => 137,
			'CONST' => 25,
			'DEC_OP' => 89,
			"-" => 115,
			"!" => 104,
			'STRING_LITERAL' => 116,
			'UNION' => 14,
			'CHAR' => 13,
			'FLOAT' => 34,
			'LONG' => 20,
			"*" => 119,
			'UNSIGNED' => 18,
			'SIZEOF' => 105,
			'STRUCT' => 19
		},
		GOTOS => {
			'multiplicative_expression' => 122,
			'conditional_expression' => 121,
			'expression' => 171,
			'relational_expression' => 106,
			'shift_expression' => 79,
			'primary_expression' => 77,
			'additive_expression' => 91,
			'unary_expression' => 118,
			'unary_operator' => 90,
			'postfix_expression' => 103,
			'assignment_expression' => 112,
			'equality_expression' => 126,
			'type_name' => 280,
			'logical_and_expression' => 110,
			'inclusive_or_expression' => 100,
			'exclusive_or_expression' => 109,
			'struct_or_union' => 3,
			'type_qualifier' => 68,
			'cast_expression' => 83,
			'enum_specifier' => 29,
			'and_expression' => 82,
			'logical_or_expression' => 81,
			'specifier_qualifier_list' => 172,
			'struct_or_union_specifier' => 32,
			'type_specifier' => 66
		}
	},
	{#State 197
		ACTIONS => {
			"-" => 115,
			"!" => 104,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			'IDENTIFIER' => 137,
			'DEC_OP' => 89,
			"&" => 80,
			"~" => 78,
			'CONSTANT' => 117,
			"*" => 119,
			'SIZEOF' => 105,
			"(" => 85,
			"+" => 127
		},
		GOTOS => {
			'shift_expression' => 281,
			'multiplicative_expression' => 122,
			'unary_operator' => 90,
			'postfix_expression' => 103,
			'cast_expression' => 83,
			'primary_expression' => 77,
			'additive_expression' => 91,
			'unary_expression' => 141
		}
	},
	{#State 198
		ACTIONS => {
			'CONSTANT' => 117,
			"~" => 78,
			"&" => 80,
			'DEC_OP' => 89,
			'IDENTIFIER' => 137,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			"-" => 115,
			"!" => 104,
			"+" => 127,
			"(" => 85,
			'SIZEOF' => 105,
			"*" => 119
		},
		GOTOS => {
			'shift_expression' => 282,
			'multiplicative_expression' => 122,
			'unary_operator' => 90,
			'postfix_expression' => 103,
			'cast_expression' => 83,
			'primary_expression' => 77,
			'unary_expression' => 141,
			'additive_expression' => 91
		}
	},
	{#State 199
		ACTIONS => {
			"!" => 104,
			"-" => 115,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			'IDENTIFIER' => 137,
			'DEC_OP' => 89,
			"&" => 80,
			"~" => 78,
			'CONSTANT' => 117,
			"*" => 119,
			'SIZEOF' => 105,
			"(" => 85,
			"+" => 127
		},
		GOTOS => {
			'unary_operator' => 90,
			'postfix_expression' => 103,
			'cast_expression' => 83,
			'primary_expression' => 77,
			'additive_expression' => 91,
			'unary_expression' => 141,
			'shift_expression' => 283,
			'multiplicative_expression' => 122
		}
	},
	{#State 200
		ACTIONS => {
			"(" => 85,
			'SIZEOF' => 105,
			"*" => 119,
			"+" => 127,
			'DEC_OP' => 89,
			"&" => 80,
			'IDENTIFIER' => 137,
			'INC_OP' => 107,
			'STRING_LITERAL' => 116,
			"!" => 104,
			"-" => 115,
			'CONSTANT' => 117,
			"~" => 78
		},
		GOTOS => {
			'cast_expression' => 83,
			'primary_expression' => 77,
			'additive_expression' => 91,
			'unary_expression' => 141,
			'unary_operator' => 90,
			'postfix_expression' => 103,
			'multiplicative_expression' => 122,
			'shift_expression' => 284
		}
	},
	{#State 201
		DEFAULT => -16
	},
	{#State 202
		ACTIONS => {
			"&" => 80,
			'DEC_OP' => 89,
			'IDENTIFIER' => 137,
			'INC_OP' => 107,
			'STRING_LITERAL' => 116,
			"!" => 104,
			"-" => 115,
			'CONSTANT' => 117,
			"~" => 78,
			";" => 93,
			"(" => 85,
			'SIZEOF' => 105,
			"*" => 119,
			"+" => 127
		},
		GOTOS => {
			'cast_expression' => 83,
			'and_expression' => 82,
			'logical_or_expression' => 81,
			'assignment_expression' => 112,
			'expression_statement' => 285,
			'equality_expression' => 126,
			'logical_and_expression' => 110,
			'inclusive_or_expression' => 100,
			'exclusive_or_expression' => 109,
			'primary_expression' => 77,
			'additive_expression' => 91,
			'unary_expression' => 118,
			'unary_operator' => 90,
			'postfix_expression' => 103,
			'conditional_expression' => 121,
			'multiplicative_expression' => 122,
			'expression' => 96,
			'relational_expression' => 106,
			'shift_expression' => 79
		}
	},
	{#State 203
		ACTIONS => {
			'SIZEOF' => 105,
			"*" => 119,
			"(" => 85,
			"+" => 127,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			"!" => 104,
			"-" => 115,
			"&" => 80,
			'DEC_OP' => 89,
			'IDENTIFIER' => 137,
			"~" => 78,
			'CONSTANT' => 117
		},
		GOTOS => {
			'primary_expression' => 77,
			'cast_expression' => 83,
			'and_expression' => 286,
			'additive_expression' => 91,
			'unary_expression' => 141,
			'unary_operator' => 90,
			'postfix_expression' => 103,
			'multiplicative_expression' => 122,
			'equality_expression' => 126,
			'relational_expression' => 106,
			'shift_expression' => 79
		}
	},
	{#State 204
		ACTIONS => {
			'CONSTANT' => 117,
			"~" => 78,
			"&" => 80,
			'DEC_OP' => 89,
			'IDENTIFIER' => 137,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			"!" => 104,
			"-" => 115,
			"+" => 127,
			"(" => 85,
			'SIZEOF' => 105,
			"*" => 119
		},
		GOTOS => {
			'shift_expression' => 79,
			'exclusive_or_expression' => 109,
			'inclusive_or_expression' => 287,
			'equality_expression' => 126,
			'relational_expression' => 106,
			'multiplicative_expression' => 122,
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'and_expression' => 82,
			'additive_expression' => 91,
			'unary_expression' => 141,
			'cast_expression' => 83,
			'primary_expression' => 77
		}
	},
	{#State 205
		DEFAULT => -200
	},
	{#State 206
		DEFAULT => -67
	},
	{#State 207
		DEFAULT => -61
	},
	{#State 208
		DEFAULT => -71
	},
	{#State 209
		DEFAULT => -64
	},
	{#State 210
		DEFAULT => -68
	},
	{#State 211
		DEFAULT => -70
	},
	{#State 212
		DEFAULT => -63
	},
	{#State 213
		DEFAULT => -66
	},
	{#State 214
		DEFAULT => -62
	},
	{#State 215
		ACTIONS => {
			"~" => 78,
			'CONSTANT' => 117,
			'INC_OP' => 107,
			'STRING_LITERAL' => 116,
			"-" => 115,
			"!" => 104,
			'DEC_OP' => 89,
			"&" => 80,
			'IDENTIFIER' => 137,
			"+" => 127,
			'SIZEOF' => 105,
			"*" => 119,
			"(" => 85
		},
		GOTOS => {
			'logical_or_expression' => 81,
			'cast_expression' => 83,
			'and_expression' => 82,
			'logical_and_expression' => 110,
			'inclusive_or_expression' => 100,
			'exclusive_or_expression' => 109,
			'assignment_expression' => 288,
			'equality_expression' => 126,
			'unary_operator' => 90,
			'postfix_expression' => 103,
			'primary_expression' => 77,
			'additive_expression' => 91,
			'unary_expression' => 118,
			'shift_expression' => 79,
			'conditional_expression' => 121,
			'multiplicative_expression' => 122,
			'relational_expression' => 106
		}
	},
	{#State 216
		DEFAULT => -65
	},
	{#State 217
		DEFAULT => -69
	},
	{#State 218
		DEFAULT => -183
	},
	{#State 219
		DEFAULT => -189
	},
	{#State 220
		ACTIONS => {
			'IDENTIFIER' => 137,
			"&" => 80,
			'DEC_OP' => 89,
			"!" => 104,
			"-" => 115,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			'CONSTANT' => 117,
			"~" => 78,
			"(" => 85,
			"*" => 119,
			'SIZEOF' => 105,
			"+" => 127
		},
		GOTOS => {
			'unary_operator' => 90,
			'postfix_expression' => 103,
			'cast_expression' => 289,
			'primary_expression' => 77,
			'unary_expression' => 141
		}
	},
	{#State 221
		ACTIONS => {
			"~" => 78,
			'CONSTANT' => 117,
			"-" => 115,
			"!" => 104,
			'INC_OP' => 107,
			'STRING_LITERAL' => 116,
			'IDENTIFIER' => 137,
			'DEC_OP' => 89,
			"&" => 80,
			"+" => 127,
			"*" => 119,
			'SIZEOF' => 105,
			"(" => 85
		},
		GOTOS => {
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'unary_expression' => 141,
			'primary_expression' => 77,
			'cast_expression' => 290
		}
	},
	{#State 222
		ACTIONS => {
			"~" => 78,
			'CONSTANT' => 117,
			"!" => 104,
			"-" => 115,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			'IDENTIFIER' => 137,
			'DEC_OP' => 89,
			"&" => 80,
			"+" => 127,
			"*" => 119,
			'SIZEOF' => 105,
			"(" => 85
		},
		GOTOS => {
			'cast_expression' => 291,
			'primary_expression' => 77,
			'unary_expression' => 141,
			'unary_operator' => 90,
			'postfix_expression' => 103
		}
	},
	{#State 223
		DEFAULT => -201
	},
	{#State 224
		ACTIONS => {
			'SIZEOF' => 105,
			"*" => 119,
			"{" => 50,
			'STRING_LITERAL' => 116,
			"!" => 104,
			'CONTINUE' => 114,
			"-" => 115,
			'DEC_OP' => 89,
			'IDENTIFIER' => 88,
			"~" => 78,
			'CASE' => 94,
			";" => 93,
			'DO' => 76,
			'CONSTANT' => 117,
			'GOTO' => 75,
			'WHILE' => 101,
			"(" => 85,
			'BREAK' => 124,
			'DEFAULT' => 125,
			'FOR' => 108,
			"+" => 127,
			'IF' => 102,
			'INC_OP' => 107,
			"&" => 80,
			'SWITCH' => 98,
			'RETURN' => 84
		},
		GOTOS => {
			'cast_expression' => 83,
			'statement' => 292,
			'and_expression' => 82,
			'logical_or_expression' => 81,
			'selection_statement' => 123,
			'assignment_expression' => 112,
			'expression_statement' => 111,
			'equality_expression' => 126,
			'inclusive_or_expression' => 100,
			'logical_and_expression' => 110,
			'jump_statement' => 86,
			'exclusive_or_expression' => 109,
			'primary_expression' => 77,
			'additive_expression' => 91,
			'unary_expression' => 118,
			'compound_statement' => 92,
			'unary_operator' => 90,
			'postfix_expression' => 103,
			'expression' => 96,
			'multiplicative_expression' => 122,
			'conditional_expression' => 121,
			'labeled_statement' => 97,
			'relational_expression' => 106,
			'shift_expression' => 79,
			'iteration_statement' => 95
		}
	},
	{#State 225
		ACTIONS => {
			"+" => 127,
			"(" => 85,
			'SIZEOF' => 105,
			"*" => 119,
			'CONSTANT' => 117,
			"~" => 78,
			"&" => 80,
			'DEC_OP' => 89,
			'IDENTIFIER' => 137,
			'INC_OP' => 107,
			'STRING_LITERAL' => 116,
			"!" => 104,
			"-" => 115
		},
		GOTOS => {
			'shift_expression' => 79,
			'relational_expression' => 293,
			'multiplicative_expression' => 122,
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'unary_expression' => 141,
			'additive_expression' => 91,
			'cast_expression' => 83,
			'primary_expression' => 77
		}
	},
	{#State 226
		ACTIONS => {
			"+" => 127,
			"(" => 85,
			"*" => 119,
			'SIZEOF' => 105,
			'CONSTANT' => 117,
			"~" => 78,
			'IDENTIFIER' => 137,
			'DEC_OP' => 89,
			"&" => 80,
			"-" => 115,
			"!" => 104,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107
		},
		GOTOS => {
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'unary_expression' => 141,
			'additive_expression' => 91,
			'primary_expression' => 77,
			'cast_expression' => 83,
			'shift_expression' => 79,
			'relational_expression' => 294,
			'multiplicative_expression' => 122
		}
	},
	{#State 227
		DEFAULT => -208
	},
	{#State 228
		DEFAULT => -86
	},
	{#State 229
		ACTIONS => {
			"(" => 85,
			"*" => 119,
			'SIZEOF' => 105,
			"{" => 229,
			"+" => 127,
			'IDENTIFIER' => 137,
			"&" => 80,
			'DEC_OP' => 89,
			"-" => 115,
			"!" => 104,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			'CONSTANT' => 117,
			"~" => 78
		},
		GOTOS => {
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'initializer' => 295,
			'initializer_list' => 296,
			'additive_expression' => 91,
			'unary_expression' => 118,
			'primary_expression' => 77,
			'shift_expression' => 79,
			'relational_expression' => 106,
			'conditional_expression' => 121,
			'multiplicative_expression' => 122,
			'logical_or_expression' => 81,
			'and_expression' => 82,
			'cast_expression' => 83,
			'exclusive_or_expression' => 109,
			'inclusive_or_expression' => 100,
			'logical_and_expression' => 110,
			'equality_expression' => 126,
			'assignment_expression' => 230
		}
	},
	{#State 230
		DEFAULT => -168
	},
	{#State 231
		DEFAULT => -84
	},
	{#State 232
		DEFAULT => -134
	},
	{#State 233
		ACTIONS => {
			'DOUBLE' => 2,
			'REGISTER' => 1,
			'ENUM' => 5,
			'VOID' => 6,
			'SHORT' => 4,
			'SIGNED' => 30,
			'VOLATILE' => 7,
			'EXTERN' => 31,
			'ELLIPSIS' => 298,
			'TYPE_NAME' => 8,
			'INT' => 10,
			'STATIC' => 11,
			'FLOAT' => 34,
			'UNION' => 14,
			'CHAR' => 13,
			'STRUCT' => 19,
			'AUTO' => 35,
			'UNSIGNED' => 18,
			'LONG' => 20,
			'TYPEDEF' => 21,
			'CONST' => 25
		},
		GOTOS => {
			'struct_or_union' => 3,
			'parameter_declaration' => 297,
			'declaration_specifiers' => 146,
			'storage_class_specifier' => 36,
			'enum_specifier' => 29,
			'type_qualifier' => 28,
			'type_specifier' => 9,
			'struct_or_union_specifier' => 32
		}
	},
	{#State 234
		DEFAULT => -136
	},
	{#State 235
		DEFAULT => -149
	},
	{#State 236
		ACTIONS => {
			"[" => 300,
			"(" => 299
		},
		DEFAULT => -157
	},
	{#State 237
		DEFAULT => -150
	},
	{#State 238
		ACTIONS => {
			"+" => 127,
			"(" => 85,
			'SIZEOF' => 105,
			"*" => 119,
			'CONSTANT' => 117,
			"~" => 78,
			'DEC_OP' => 89,
			"&" => 80,
			'IDENTIFIER' => 137,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			"-" => 115,
			"!" => 104,
			"]" => 301
		},
		GOTOS => {
			'inclusive_or_expression' => 100,
			'logical_and_expression' => 110,
			'exclusive_or_expression' => 109,
			'equality_expression' => 126,
			'logical_or_expression' => 81,
			'constant_expression' => 302,
			'cast_expression' => 83,
			'and_expression' => 82,
			'shift_expression' => 79,
			'conditional_expression' => 140,
			'multiplicative_expression' => 122,
			'relational_expression' => 106,
			'unary_operator' => 90,
			'postfix_expression' => 103,
			'primary_expression' => 77,
			'unary_expression' => 141,
			'additive_expression' => 91
		}
	},
	{#State 239
		ACTIONS => {
			")" => 305,
			'DOUBLE' => 2,
			'REGISTER' => 1,
			'VOID' => 6,
			'ENUM' => 5,
			"(" => 239,
			'SHORT' => 4,
			'EXTERN' => 31,
			'SIGNED' => 30,
			'VOLATILE' => 7,
			'INT' => 10,
			'TYPE_NAME' => 8,
			'UNION' => 14,
			'CHAR' => 13,
			"[" => 238,
			'STATIC' => 11,
			'FLOAT' => 34,
			'LONG' => 20,
			'STRUCT' => 19,
			'UNSIGNED' => 18,
			'AUTO' => 35,
			"*" => 17,
			'TYPEDEF' => 21,
			'CONST' => 25,
			'IDENTIFIER' => 24
		},
		GOTOS => {
			'type_qualifier' => 28,
			'enum_specifier' => 29,
			'direct_declarator' => 37,
			'direct_abstract_declarator' => 236,
			'storage_class_specifier' => 36,
			'declarator' => 57,
			'struct_or_union_specifier' => 32,
			'pointer' => 240,
			'parameter_list' => 144,
			'type_specifier' => 9,
			'abstract_declarator' => 304,
			'parameter_type_list' => 303,
			'declaration_specifiers' => 146,
			'parameter_declaration' => 143,
			'struct_or_union' => 3
		}
	},
	{#State 240
		ACTIONS => {
			"[" => 238,
			'IDENTIFIER' => 24,
			"(" => 239
		},
		DEFAULT => -156,
		GOTOS => {
			'direct_declarator' => 59,
			'direct_abstract_declarator' => 306
		}
	},
	{#State 241
		ACTIONS => {
			'IDENTIFIER' => 307
		}
	},
	{#State 242
		DEFAULT => -137
	},
	{#State 243
		DEFAULT => -104
	},
	{#State 244
		DEFAULT => -111
	},
	{#State 245
		ACTIONS => {
			'IDENTIFIER' => 24,
			"(" => 27,
			":" => 152,
			"*" => 17
		},
		GOTOS => {
			'pointer' => 33,
			'struct_declarator' => 308,
			'direct_declarator' => 37,
			'declarator' => 153
		}
	},
	{#State 246
		DEFAULT => -119
	},
	{#State 247
		ACTIONS => {
			'CONSTANT' => 117,
			"~" => 78,
			'DEC_OP' => 89,
			"&" => 80,
			'IDENTIFIER' => 137,
			'INC_OP' => 107,
			'STRING_LITERAL' => 116,
			"!" => 104,
			"-" => 115,
			"+" => 127,
			"(" => 85,
			'SIZEOF' => 105,
			"*" => 119
		},
		GOTOS => {
			'primary_expression' => 77,
			'unary_expression' => 141,
			'additive_expression' => 91,
			'unary_operator' => 90,
			'postfix_expression' => 103,
			'conditional_expression' => 140,
			'multiplicative_expression' => 122,
			'relational_expression' => 106,
			'shift_expression' => 79,
			'cast_expression' => 83,
			'and_expression' => 82,
			'logical_or_expression' => 81,
			'constant_expression' => 309,
			'equality_expression' => 126,
			'inclusive_or_expression' => 100,
			'logical_and_expression' => 110,
			'exclusive_or_expression' => 109
		}
	},
	{#State 248
		DEFAULT => -122
	},
	{#State 249
		DEFAULT => -125
	},
	{#State 250
		DEFAULT => -127
	},
	{#State 251
		DEFAULT => -199
	},
	{#State 252
		ACTIONS => {
			"(" => 310
		}
	},
	{#State 253
		ACTIONS => {
			"-" => 181,
			"+" => 180
		},
		DEFAULT => -38
	},
	{#State 254
		ACTIONS => {
			"+" => 180,
			"-" => 181
		},
		DEFAULT => -37
	},
	{#State 255
		ACTIONS => {
			'AND_OP' => 204
		},
		DEFAULT => -56
	},
	{#State 256
		ACTIONS => {
			"," => 183,
			":" => 311
		}
	},
	{#State 257
		ACTIONS => {
			'NE_OP' => 226,
			'EQ_OP' => 225
		},
		DEFAULT => -48
	},
	{#State 258
		DEFAULT => -203
	},
	{#State 259
		DEFAULT => -4
	},
	{#State 260
		DEFAULT => -155
	},
	{#State 261
		ACTIONS => {
			"(" => 262,
			"[" => 238
		},
		DEFAULT => -156,
		GOTOS => {
			'direct_abstract_declarator' => 306
		}
	},
	{#State 262
		ACTIONS => {
			'VOLATILE' => 7,
			'SIGNED' => 30,
			'EXTERN' => 31,
			'TYPE_NAME' => 8,
			'INT' => 10,
			'REGISTER' => 1,
			'DOUBLE' => 2,
			")" => 305,
			'SHORT' => 4,
			"(" => 262,
			'ENUM' => 5,
			'VOID' => 6,
			'TYPEDEF' => 21,
			'CONST' => 25,
			'FLOAT' => 34,
			'STATIC' => 11,
			'CHAR' => 13,
			"[" => 238,
			'UNION' => 14,
			'AUTO' => 35,
			"*" => 17,
			'UNSIGNED' => 18,
			'STRUCT' => 19,
			'LONG' => 20
		},
		GOTOS => {
			'struct_or_union_specifier' => 32,
			'pointer' => 261,
			'parameter_list' => 144,
			'type_specifier' => 9,
			'enum_specifier' => 29,
			'type_qualifier' => 28,
			'storage_class_specifier' => 36,
			'direct_abstract_declarator' => 236,
			'declaration_specifiers' => 146,
			'parameter_declaration' => 143,
			'struct_or_union' => 3,
			'abstract_declarator' => 304,
			'parameter_type_list' => 303
		}
	},
	{#State 263
		ACTIONS => {
			'CONSTANT' => 117,
			"~" => 78,
			'DEC_OP' => 89,
			"&" => 80,
			'IDENTIFIER' => 137,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			"!" => 104,
			"-" => 115,
			"+" => 127,
			"(" => 85,
			'SIZEOF' => 105,
			"*" => 119
		},
		GOTOS => {
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'unary_expression' => 141,
			'cast_expression' => 312,
			'primary_expression' => 77
		}
	},
	{#State 264
		DEFAULT => -185
	},
	{#State 265
		DEFAULT => -179
	},
	{#State 266
		ACTIONS => {
			"/" => 222,
			"%" => 221,
			"*" => 220
		},
		DEFAULT => -34
	},
	{#State 267
		ACTIONS => {
			"/" => 222,
			"%" => 221,
			"*" => 220
		},
		DEFAULT => -35
	},
	{#State 268
		ACTIONS => {
			";" => 93,
			"~" => 78,
			'CASE' => 94,
			'GOTO' => 75,
			'CONSTANT' => 117,
			'DO' => 76,
			'CONTINUE' => 114,
			"-" => 115,
			"!" => 104,
			'STRING_LITERAL' => 116,
			'IDENTIFIER' => 88,
			'DEC_OP' => 89,
			"{" => 50,
			"*" => 119,
			'SIZEOF' => 105,
			'RETURN' => 84,
			'INC_OP' => 107,
			'SWITCH' => 98,
			"&" => 80,
			"+" => 127,
			'IF' => 102,
			'WHILE' => 101,
			'FOR' => 108,
			'BREAK' => 124,
			"(" => 85,
			'DEFAULT' => 125
		},
		GOTOS => {
			'exclusive_or_expression' => 109,
			'logical_and_expression' => 110,
			'jump_statement' => 86,
			'inclusive_or_expression' => 100,
			'equality_expression' => 126,
			'assignment_expression' => 112,
			'expression_statement' => 111,
			'logical_or_expression' => 81,
			'selection_statement' => 123,
			'and_expression' => 82,
			'statement' => 313,
			'cast_expression' => 83,
			'iteration_statement' => 95,
			'shift_expression' => 79,
			'relational_expression' => 106,
			'labeled_statement' => 97,
			'conditional_expression' => 121,
			'multiplicative_expression' => 122,
			'expression' => 96,
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'unary_expression' => 118,
			'additive_expression' => 91,
			'compound_statement' => 92,
			'primary_expression' => 77
		}
	},
	{#State 269
		DEFAULT => -73
	},
	{#State 270
		ACTIONS => {
			")" => 314,
			"," => 183
		}
	},
	{#State 271
		ACTIONS => {
			"^" => 203
		},
		DEFAULT => -52
	},
	{#State 272
		ACTIONS => {
			")" => 315,
			"," => 183
		}
	},
	{#State 273
		ACTIONS => {
			"," => 183,
			")" => 316
		}
	},
	{#State 274
		DEFAULT => -10
	},
	{#State 275
		DEFAULT => -9
	},
	{#State 276
		DEFAULT => -7
	},
	{#State 277
		DEFAULT => -13
	},
	{#State 278
		ACTIONS => {
			")" => 317,
			"," => 318
		}
	},
	{#State 279
		ACTIONS => {
			"]" => 319,
			"," => 183
		}
	},
	{#State 280
		ACTIONS => {
			")" => 320
		}
	},
	{#State 281
		ACTIONS => {
			'RIGHT_OP' => 164,
			'LEFT_OP' => 165
		},
		DEFAULT => -42
	},
	{#State 282
		ACTIONS => {
			'LEFT_OP' => 165,
			'RIGHT_OP' => 164
		},
		DEFAULT => -40
	},
	{#State 283
		ACTIONS => {
			'LEFT_OP' => 165,
			'RIGHT_OP' => 164
		},
		DEFAULT => -41
	},
	{#State 284
		ACTIONS => {
			'LEFT_OP' => 165,
			'RIGHT_OP' => 164
		},
		DEFAULT => -43
	},
	{#State 285
		ACTIONS => {
			"&" => 80,
			'DEC_OP' => 89,
			'IDENTIFIER' => 137,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			"-" => 115,
			"!" => 104,
			'CONSTANT' => 117,
			"~" => 78,
			";" => 93,
			"(" => 85,
			'SIZEOF' => 105,
			"*" => 119,
			"+" => 127
		},
		GOTOS => {
			'logical_or_expression' => 81,
			'and_expression' => 82,
			'cast_expression' => 83,
			'exclusive_or_expression' => 109,
			'inclusive_or_expression' => 100,
			'logical_and_expression' => 110,
			'equality_expression' => 126,
			'assignment_expression' => 112,
			'expression_statement' => 321,
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'unary_expression' => 118,
			'additive_expression' => 91,
			'primary_expression' => 77,
			'shift_expression' => 79,
			'relational_expression' => 106,
			'expression' => 96,
			'conditional_expression' => 121,
			'multiplicative_expression' => 122
		}
	},
	{#State 286
		ACTIONS => {
			"&" => 168
		},
		DEFAULT => -50
	},
	{#State 287
		ACTIONS => {
			"|" => 186
		},
		DEFAULT => -54
	},
	{#State 288
		DEFAULT => -60
	},
	{#State 289
		DEFAULT => -30
	},
	{#State 290
		DEFAULT => -32
	},
	{#State 291
		DEFAULT => -31
	},
	{#State 292
		DEFAULT => -181
	},
	{#State 293
		ACTIONS => {
			">" => 199,
			"<" => 198,
			'GE_OP' => 200,
			'LE_OP' => 197
		},
		DEFAULT => -45
	},
	{#State 294
		ACTIONS => {
			">" => 199,
			"<" => 198,
			'GE_OP' => 200,
			'LE_OP' => 197
		},
		DEFAULT => -46
	},
	{#State 295
		DEFAULT => -171
	},
	{#State 296
		ACTIONS => {
			"," => 322,
			"}" => 323
		}
	},
	{#State 297
		DEFAULT => -148
	},
	{#State 298
		DEFAULT => -146
	},
	{#State 299
		ACTIONS => {
			'CONST' => 25,
			'TYPEDEF' => 21,
			'STRUCT' => 19,
			'UNSIGNED' => 18,
			'AUTO' => 35,
			'LONG' => 20,
			'STATIC' => 11,
			'FLOAT' => 34,
			'UNION' => 14,
			'CHAR' => 13,
			'TYPE_NAME' => 8,
			'INT' => 10,
			'SIGNED' => 30,
			'VOLATILE' => 7,
			'EXTERN' => 31,
			'VOID' => 6,
			'ENUM' => 5,
			'SHORT' => 4,
			'DOUBLE' => 2,
			'REGISTER' => 1,
			")" => 325
		},
		GOTOS => {
			'parameter_declaration' => 143,
			'struct_or_union' => 3,
			'declaration_specifiers' => 146,
			'parameter_type_list' => 324,
			'parameter_list' => 144,
			'type_specifier' => 9,
			'struct_or_union_specifier' => 32,
			'storage_class_specifier' => 36,
			'type_qualifier' => 28,
			'enum_specifier' => 29
		}
	},
	{#State 300
		ACTIONS => {
			"*" => 119,
			'SIZEOF' => 105,
			"(" => 85,
			"+" => 127,
			"-" => 115,
			"]" => 327,
			"!" => 104,
			'INC_OP' => 107,
			'STRING_LITERAL' => 116,
			'IDENTIFIER' => 137,
			'DEC_OP' => 89,
			"&" => 80,
			"~" => 78,
			'CONSTANT' => 117
		},
		GOTOS => {
			'conditional_expression' => 140,
			'multiplicative_expression' => 122,
			'relational_expression' => 106,
			'shift_expression' => 79,
			'primary_expression' => 77,
			'additive_expression' => 91,
			'unary_expression' => 141,
			'unary_operator' => 90,
			'postfix_expression' => 103,
			'equality_expression' => 126,
			'logical_and_expression' => 110,
			'inclusive_or_expression' => 100,
			'exclusive_or_expression' => 109,
			'cast_expression' => 83,
			'and_expression' => 82,
			'logical_or_expression' => 81,
			'constant_expression' => 326
		}
	},
	{#State 301
		DEFAULT => -160
	},
	{#State 302
		ACTIONS => {
			"]" => 328
		}
	},
	{#State 303
		ACTIONS => {
			")" => 329
		}
	},
	{#State 304
		ACTIONS => {
			")" => 330
		}
	},
	{#State 305
		DEFAULT => -164
	},
	{#State 306
		ACTIONS => {
			"(" => 299,
			"[" => 300
		},
		DEFAULT => -158
	},
	{#State 307
		DEFAULT => -153
	},
	{#State 308
		DEFAULT => -117
	},
	{#State 309
		DEFAULT => -120
	},
	{#State 310
		ACTIONS => {
			"+" => 127,
			"*" => 119,
			'SIZEOF' => 105,
			"(" => 85,
			"~" => 78,
			'CONSTANT' => 117,
			"!" => 104,
			"-" => 115,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			'IDENTIFIER' => 137,
			"&" => 80,
			'DEC_OP' => 89
		},
		GOTOS => {
			'and_expression' => 82,
			'cast_expression' => 83,
			'logical_or_expression' => 81,
			'equality_expression' => 126,
			'assignment_expression' => 112,
			'exclusive_or_expression' => 109,
			'logical_and_expression' => 110,
			'inclusive_or_expression' => 100,
			'unary_expression' => 118,
			'additive_expression' => 91,
			'primary_expression' => 77,
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'relational_expression' => 106,
			'conditional_expression' => 121,
			'multiplicative_expression' => 122,
			'expression' => 331,
			'shift_expression' => 79
		}
	},
	{#State 311
		ACTIONS => {
			"+" => 127,
			"(" => 85,
			"*" => 119,
			'SIZEOF' => 105,
			'CONSTANT' => 117,
			"~" => 78,
			'IDENTIFIER' => 137,
			"&" => 80,
			'DEC_OP' => 89,
			"-" => 115,
			"!" => 104,
			'INC_OP' => 107,
			'STRING_LITERAL' => 116
		},
		GOTOS => {
			'logical_or_expression' => 81,
			'and_expression' => 82,
			'cast_expression' => 83,
			'exclusive_or_expression' => 109,
			'logical_and_expression' => 110,
			'inclusive_or_expression' => 100,
			'equality_expression' => 126,
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'additive_expression' => 91,
			'unary_expression' => 141,
			'primary_expression' => 77,
			'shift_expression' => 79,
			'relational_expression' => 106,
			'conditional_expression' => 332,
			'multiplicative_expression' => 122
		}
	},
	{#State 312
		DEFAULT => -28
	},
	{#State 313
		DEFAULT => -180
	},
	{#State 314
		ACTIONS => {
			"+" => 127,
			'IF' => 102,
			'WHILE' => 101,
			"(" => 85,
			'DEFAULT' => 125,
			'BREAK' => 124,
			'FOR' => 108,
			'RETURN' => 84,
			'INC_OP' => 107,
			"&" => 80,
			'SWITCH' => 98,
			"{" => 50,
			'SIZEOF' => 105,
			"*" => 119,
			"~" => 78,
			'CASE' => 94,
			";" => 93,
			'DO' => 76,
			'CONSTANT' => 117,
			'GOTO' => 75,
			'STRING_LITERAL' => 116,
			"-" => 115,
			"!" => 104,
			'CONTINUE' => 114,
			'DEC_OP' => 89,
			'IDENTIFIER' => 88
		},
		GOTOS => {
			'exclusive_or_expression' => 109,
			'jump_statement' => 86,
			'logical_and_expression' => 110,
			'inclusive_or_expression' => 100,
			'equality_expression' => 126,
			'assignment_expression' => 112,
			'expression_statement' => 111,
			'selection_statement' => 123,
			'logical_or_expression' => 81,
			'and_expression' => 82,
			'statement' => 333,
			'cast_expression' => 83,
			'iteration_statement' => 95,
			'shift_expression' => 79,
			'relational_expression' => 106,
			'multiplicative_expression' => 122,
			'labeled_statement' => 97,
			'conditional_expression' => 121,
			'expression' => 96,
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'additive_expression' => 91,
			'compound_statement' => 92,
			'unary_expression' => 118,
			'primary_expression' => 77
		}
	},
	{#State 315
		ACTIONS => {
			'RETURN' => 84,
			'SWITCH' => 98,
			"&" => 80,
			'INC_OP' => 107,
			'IF' => 102,
			"+" => 127,
			'FOR' => 108,
			'BREAK' => 124,
			'DEFAULT' => 125,
			"(" => 85,
			'WHILE' => 101,
			'GOTO' => 75,
			'DO' => 76,
			'CONSTANT' => 117,
			";" => 93,
			"~" => 78,
			'CASE' => 94,
			'IDENTIFIER' => 88,
			'DEC_OP' => 89,
			'CONTINUE' => 114,
			"-" => 115,
			"!" => 104,
			'STRING_LITERAL' => 116,
			"{" => 50,
			"*" => 119,
			'SIZEOF' => 105
		},
		GOTOS => {
			'equality_expression' => 126,
			'expression_statement' => 111,
			'assignment_expression' => 112,
			'exclusive_or_expression' => 109,
			'inclusive_or_expression' => 100,
			'logical_and_expression' => 110,
			'jump_statement' => 86,
			'and_expression' => 82,
			'cast_expression' => 83,
			'statement' => 334,
			'logical_or_expression' => 81,
			'selection_statement' => 123,
			'relational_expression' => 106,
			'expression' => 96,
			'conditional_expression' => 121,
			'multiplicative_expression' => 122,
			'labeled_statement' => 97,
			'shift_expression' => 79,
			'iteration_statement' => 95,
			'compound_statement' => 92,
			'unary_expression' => 118,
			'additive_expression' => 91,
			'primary_expression' => 77,
			'postfix_expression' => 103,
			'unary_operator' => 90
		}
	},
	{#State 316
		ACTIONS => {
			"*" => 119,
			'SIZEOF' => 105,
			"{" => 50,
			'IDENTIFIER' => 88,
			'DEC_OP' => 89,
			'CONTINUE' => 114,
			"!" => 104,
			"-" => 115,
			'STRING_LITERAL' => 116,
			'GOTO' => 75,
			'DO' => 76,
			'CONSTANT' => 117,
			";" => 93,
			"~" => 78,
			'CASE' => 94,
			'FOR' => 108,
			'DEFAULT' => 125,
			'BREAK' => 124,
			"(" => 85,
			'WHILE' => 101,
			'IF' => 102,
			"+" => 127,
			"&" => 80,
			'SWITCH' => 98,
			'INC_OP' => 107,
			'RETURN' => 84
		},
		GOTOS => {
			'and_expression' => 82,
			'statement' => 335,
			'cast_expression' => 83,
			'selection_statement' => 123,
			'logical_or_expression' => 81,
			'equality_expression' => 126,
			'expression_statement' => 111,
			'assignment_expression' => 112,
			'exclusive_or_expression' => 109,
			'jump_statement' => 86,
			'logical_and_expression' => 110,
			'inclusive_or_expression' => 100,
			'unary_expression' => 118,
			'compound_statement' => 92,
			'additive_expression' => 91,
			'primary_expression' => 77,
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'relational_expression' => 106,
			'multiplicative_expression' => 122,
			'conditional_expression' => 121,
			'labeled_statement' => 97,
			'expression' => 96,
			'iteration_statement' => 95,
			'shift_expression' => 79
		}
	},
	{#State 317
		DEFAULT => -8
	},
	{#State 318
		ACTIONS => {
			'CONSTANT' => 117,
			"~" => 78,
			"&" => 80,
			'DEC_OP' => 89,
			'IDENTIFIER' => 137,
			'STRING_LITERAL' => 116,
			'INC_OP' => 107,
			"!" => 104,
			"-" => 115,
			"+" => 127,
			"(" => 85,
			'SIZEOF' => 105,
			"*" => 119
		},
		GOTOS => {
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'unary_expression' => 118,
			'additive_expression' => 91,
			'primary_expression' => 77,
			'shift_expression' => 79,
			'relational_expression' => 106,
			'multiplicative_expression' => 122,
			'conditional_expression' => 121,
			'logical_or_expression' => 81,
			'and_expression' => 82,
			'cast_expression' => 83,
			'exclusive_or_expression' => 109,
			'inclusive_or_expression' => 100,
			'logical_and_expression' => 110,
			'equality_expression' => 126,
			'assignment_expression' => 336
		}
	},
	{#State 319
		DEFAULT => -6
	},
	{#State 320
		DEFAULT => -20
	},
	{#State 321
		ACTIONS => {
			"*" => 119,
			'SIZEOF' => 105,
			"(" => 85,
			"+" => 127,
			")" => 338,
			"-" => 115,
			"!" => 104,
			'INC_OP' => 107,
			'STRING_LITERAL' => 116,
			'IDENTIFIER' => 137,
			'DEC_OP' => 89,
			"&" => 80,
			"~" => 78,
			'CONSTANT' => 117
		},
		GOTOS => {
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'additive_expression' => 91,
			'unary_expression' => 118,
			'primary_expression' => 77,
			'shift_expression' => 79,
			'relational_expression' => 106,
			'expression' => 337,
			'multiplicative_expression' => 122,
			'conditional_expression' => 121,
			'logical_or_expression' => 81,
			'and_expression' => 82,
			'cast_expression' => 83,
			'exclusive_or_expression' => 109,
			'inclusive_or_expression' => 100,
			'logical_and_expression' => 110,
			'equality_expression' => 126,
			'assignment_expression' => 112
		}
	},
	{#State 322
		ACTIONS => {
			'CONSTANT' => 117,
			"~" => 78,
			'IDENTIFIER' => 137,
			"}" => 340,
			"&" => 80,
			'DEC_OP' => 89,
			"!" => 104,
			"-" => 115,
			'INC_OP' => 107,
			'STRING_LITERAL' => 116,
			"{" => 229,
			"+" => 127,
			"(" => 85,
			"*" => 119,
			'SIZEOF' => 105
		},
		GOTOS => {
			'primary_expression' => 77,
			'additive_expression' => 91,
			'unary_expression' => 118,
			'initializer' => 339,
			'unary_operator' => 90,
			'postfix_expression' => 103,
			'multiplicative_expression' => 122,
			'conditional_expression' => 121,
			'relational_expression' => 106,
			'shift_expression' => 79,
			'cast_expression' => 83,
			'and_expression' => 82,
			'logical_or_expression' => 81,
			'assignment_expression' => 230,
			'equality_expression' => 126,
			'logical_and_expression' => 110,
			'inclusive_or_expression' => 100,
			'exclusive_or_expression' => 109
		}
	},
	{#State 323
		DEFAULT => -169
	},
	{#State 324
		ACTIONS => {
			")" => 341
		}
	},
	{#State 325
		DEFAULT => -166
	},
	{#State 326
		ACTIONS => {
			"]" => 342
		}
	},
	{#State 327
		DEFAULT => -162
	},
	{#State 328
		DEFAULT => -161
	},
	{#State 329
		DEFAULT => -165
	},
	{#State 330
		DEFAULT => -159
	},
	{#State 331
		ACTIONS => {
			")" => 343,
			"," => 183
		}
	},
	{#State 332
		DEFAULT => -58
	},
	{#State 333
		DEFAULT => -194
	},
	{#State 334
		DEFAULT => -195
	},
	{#State 335
		ACTIONS => {
			'ELSE' => 344
		},
		DEFAULT => -192
	},
	{#State 336
		DEFAULT => -14
	},
	{#State 337
		ACTIONS => {
			")" => 345,
			"," => 183
		}
	},
	{#State 338
		ACTIONS => {
			"(" => 85,
			'BREAK' => 124,
			'DEFAULT' => 125,
			'FOR' => 108,
			'WHILE' => 101,
			'IF' => 102,
			"+" => 127,
			'SWITCH' => 98,
			"&" => 80,
			'INC_OP' => 107,
			'RETURN' => 84,
			'SIZEOF' => 105,
			"*" => 119,
			"{" => 50,
			'DEC_OP' => 89,
			'IDENTIFIER' => 88,
			'STRING_LITERAL' => 116,
			'CONTINUE' => 114,
			"!" => 104,
			"-" => 115,
			'DO' => 76,
			'CONSTANT' => 117,
			'GOTO' => 75,
			"~" => 78,
			'CASE' => 94,
			";" => 93
		},
		GOTOS => {
			'inclusive_or_expression' => 100,
			'jump_statement' => 86,
			'logical_and_expression' => 110,
			'exclusive_or_expression' => 109,
			'expression_statement' => 111,
			'assignment_expression' => 112,
			'equality_expression' => 126,
			'selection_statement' => 123,
			'logical_or_expression' => 81,
			'cast_expression' => 83,
			'statement' => 346,
			'and_expression' => 82,
			'shift_expression' => 79,
			'iteration_statement' => 95,
			'expression' => 96,
			'labeled_statement' => 97,
			'multiplicative_expression' => 122,
			'conditional_expression' => 121,
			'relational_expression' => 106,
			'unary_operator' => 90,
			'postfix_expression' => 103,
			'primary_expression' => 77,
			'unary_expression' => 118,
			'additive_expression' => 91,
			'compound_statement' => 92
		}
	},
	{#State 339
		DEFAULT => -172
	},
	{#State 340
		DEFAULT => -170
	},
	{#State 341
		DEFAULT => -167
	},
	{#State 342
		DEFAULT => -163
	},
	{#State 343
		ACTIONS => {
			";" => 347
		}
	},
	{#State 344
		ACTIONS => {
			'WHILE' => 101,
			'DEFAULT' => 125,
			"(" => 85,
			'BREAK' => 124,
			'FOR' => 108,
			"+" => 127,
			'IF' => 102,
			'INC_OP' => 107,
			'SWITCH' => 98,
			"&" => 80,
			'RETURN' => 84,
			'SIZEOF' => 105,
			"*" => 119,
			"{" => 50,
			'STRING_LITERAL' => 116,
			"-" => 115,
			'CONTINUE' => 114,
			"!" => 104,
			'DEC_OP' => 89,
			'IDENTIFIER' => 88,
			'CASE' => 94,
			"~" => 78,
			";" => 93,
			'DO' => 76,
			'CONSTANT' => 117,
			'GOTO' => 75
		},
		GOTOS => {
			'assignment_expression' => 112,
			'expression_statement' => 111,
			'equality_expression' => 126,
			'jump_statement' => 86,
			'logical_and_expression' => 110,
			'inclusive_or_expression' => 100,
			'exclusive_or_expression' => 109,
			'statement' => 348,
			'cast_expression' => 83,
			'and_expression' => 82,
			'selection_statement' => 123,
			'logical_or_expression' => 81,
			'multiplicative_expression' => 122,
			'labeled_statement' => 97,
			'conditional_expression' => 121,
			'expression' => 96,
			'relational_expression' => 106,
			'iteration_statement' => 95,
			'shift_expression' => 79,
			'primary_expression' => 77,
			'additive_expression' => 91,
			'unary_expression' => 118,
			'compound_statement' => 92,
			'unary_operator' => 90,
			'postfix_expression' => 103
		}
	},
	{#State 345
		ACTIONS => {
			'WHILE' => 101,
			'FOR' => 108,
			'DEFAULT' => 125,
			"(" => 85,
			'BREAK' => 124,
			"+" => 127,
			'IF' => 102,
			'INC_OP' => 107,
			"&" => 80,
			'SWITCH' => 98,
			'RETURN' => 84,
			"*" => 119,
			'SIZEOF' => 105,
			"{" => 50,
			"!" => 104,
			'CONTINUE' => 114,
			"-" => 115,
			'STRING_LITERAL' => 116,
			'IDENTIFIER' => 88,
			'DEC_OP' => 89,
			";" => 93,
			"~" => 78,
			'CASE' => 94,
			'GOTO' => 75,
			'CONSTANT' => 117,
			'DO' => 76
		},
		GOTOS => {
			'postfix_expression' => 103,
			'unary_operator' => 90,
			'additive_expression' => 91,
			'compound_statement' => 92,
			'unary_expression' => 118,
			'primary_expression' => 77,
			'iteration_statement' => 95,
			'shift_expression' => 79,
			'relational_expression' => 106,
			'conditional_expression' => 121,
			'multiplicative_expression' => 122,
			'labeled_statement' => 97,
			'expression' => 96,
			'selection_statement' => 123,
			'logical_or_expression' => 81,
			'and_expression' => 82,
			'statement' => 349,
			'cast_expression' => 83,
			'exclusive_or_expression' => 109,
			'logical_and_expression' => 110,
			'jump_statement' => 86,
			'inclusive_or_expression' => 100,
			'equality_expression' => 126,
			'assignment_expression' => 112,
			'expression_statement' => 111
		}
	},
	{#State 346
		DEFAULT => -197
	},
	{#State 347
		DEFAULT => -196
	},
	{#State 348
		DEFAULT => -193
	},
	{#State 349
		DEFAULT => -198
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 8528 ./ansic.pm
	],
	[#Rule primaryExpression_is_IDENTIFIER
		 'primary_expression', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8535 ./ansic.pm
	],
	[#Rule primaryExpression_is_CONSTANT
		 'primary_expression', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8542 ./ansic.pm
	],
	[#Rule primaryExpression_is_STRING_LITERAL
		 'primary_expression', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8549 ./ansic.pm
	],
	[#Rule primaryExpression_is_LP_expression_RP
		 'primary_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8556 ./ansic.pm
	],
	[#Rule postfixExpression_is_primaryExpression
		 'postfix_expression', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8563 ./ansic.pm
	],
	[#Rule postfixExpression_is_postfixExpression_LB_expression_RB
		 'postfix_expression', 4,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8570 ./ansic.pm
	],
	[#Rule postfixExpression_is_postfixExpression_LP_RP
		 'postfix_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8577 ./ansic.pm
	],
	[#Rule postfixExpression_is_postfixExpression_LP_argumentExpressionList_RP
		 'postfix_expression', 4,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8584 ./ansic.pm
	],
	[#Rule postfixExpression_is_postfixExpression_DOT_IDENTIFIER
		 'postfix_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8591 ./ansic.pm
	],
	[#Rule postfixExpression_is_postfixExpression_PTR_OP_IDENTIFIER
		 'postfix_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8598 ./ansic.pm
	],
	[#Rule postfixExpression_is_postfixExpression_INC_OP
		 'postfix_expression', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8605 ./ansic.pm
	],
	[#Rule postfixExpression_is_postfixExpression_DEC_OP
		 'postfix_expression', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8612 ./ansic.pm
	],
	[#Rule argumentExpressionList_is_assignmentExpression
		 'argument_expression_list', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8619 ./ansic.pm
	],
	[#Rule argumentExpressionList_is_argumentExpressionList_COMMA_assignmentExpression
		 'argument_expression_list', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8626 ./ansic.pm
	],
	[#Rule unaryExpression_is_postfixExpression
		 'unary_expression', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8633 ./ansic.pm
	],
	[#Rule unaryExpression_is_INC_OP_unaryExpression
		 'unary_expression', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8640 ./ansic.pm
	],
	[#Rule unaryExpression_is_DEC_OP_unaryExpression
		 'unary_expression', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8647 ./ansic.pm
	],
	[#Rule unaryExpression_is_unaryOperator_castExpression
		 'unary_expression', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8654 ./ansic.pm
	],
	[#Rule unaryExpression_is_SIZEOF_unaryExpression
		 'unary_expression', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8661 ./ansic.pm
	],
	[#Rule unaryExpression_is_SIZEOF_LP_typeName_RP
		 'unary_expression', 4,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8668 ./ansic.pm
	],
	[#Rule unaryOperator_is_AMP
		 'unary_operator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8675 ./ansic.pm
	],
	[#Rule unaryOperator_is_STAR
		 'unary_operator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8682 ./ansic.pm
	],
	[#Rule unaryOperator_is_PLUS
		 'unary_operator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8689 ./ansic.pm
	],
	[#Rule unaryOperator_is_MINUS
		 'unary_operator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8696 ./ansic.pm
	],
	[#Rule unaryOperator_is_BNOT
		 'unary_operator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8703 ./ansic.pm
	],
	[#Rule unaryOperator_is_NOT
		 'unary_operator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8710 ./ansic.pm
	],
	[#Rule castExpression_is_unaryExpression
		 'cast_expression', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8717 ./ansic.pm
	],
	[#Rule castExpression_is_LP_typeName_RP_castExpression
		 'cast_expression', 4,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8724 ./ansic.pm
	],
	[#Rule multiplicativeExpression_is_castExpression
		 'multiplicative_expression', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8731 ./ansic.pm
	],
	[#Rule multiplicativeExpression_is_multiplicativeExpression_STAR_castExpression
		 'multiplicative_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8738 ./ansic.pm
	],
	[#Rule multiplicativeExpression_is_multiplicativeExpression_DIV_castExpression
		 'multiplicative_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8745 ./ansic.pm
	],
	[#Rule multiplicativeExpression_is_multiplicativeExpression_PERCENT_castExpression
		 'multiplicative_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8752 ./ansic.pm
	],
	[#Rule additiveExpression_is_multiplicativeExpression
		 'additive_expression', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8759 ./ansic.pm
	],
	[#Rule additiveExpression_is_additiveExpression_PLUS_multiplicativeExpression
		 'additive_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8766 ./ansic.pm
	],
	[#Rule additiveExpression_is_additiveExpression_MINUS_multiplicativeExpression
		 'additive_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8773 ./ansic.pm
	],
	[#Rule shiftExpression_is_additiveExpression
		 'shift_expression', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8780 ./ansic.pm
	],
	[#Rule shiftExpression_is_shiftExpression_LEFT_OP_additiveExpression
		 'shift_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8787 ./ansic.pm
	],
	[#Rule shiftExpression_is_shiftExpression_RIGHT_OP_additiveExpression
		 'shift_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8794 ./ansic.pm
	],
	[#Rule relationalExpression_is_shiftExpression
		 'relational_expression', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8801 ./ansic.pm
	],
	[#Rule relationalExpression_is_relationalExpression_LT_shiftExpression
		 'relational_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8808 ./ansic.pm
	],
	[#Rule relationalExpression_is_relationalExpression_GT_shiftExpression
		 'relational_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8815 ./ansic.pm
	],
	[#Rule relationalExpression_is_relationalExpression_LE_OP_shiftExpression
		 'relational_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8822 ./ansic.pm
	],
	[#Rule relationalExpression_is_relationalExpression_GE_OP_shiftExpression
		 'relational_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8829 ./ansic.pm
	],
	[#Rule equalityExpression_is_relationalExpression
		 'equality_expression', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8836 ./ansic.pm
	],
	[#Rule equalityExpression_is_equalityExpression_EQ_OP_relationalExpression
		 'equality_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8843 ./ansic.pm
	],
	[#Rule equalityExpression_is_equalityExpression_NE_OP_relationalExpression
		 'equality_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8850 ./ansic.pm
	],
	[#Rule andExpression_is_equalityExpression
		 'and_expression', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8857 ./ansic.pm
	],
	[#Rule andExpression_is_andExpression_AMP_equalityExpression
		 'and_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8864 ./ansic.pm
	],
	[#Rule exclusiveOrExpression_is_andExpression
		 'exclusive_or_expression', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8871 ./ansic.pm
	],
	[#Rule exclusiveOrExpression_is_exclusiveOrExpression_XOR_andExpression
		 'exclusive_or_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8878 ./ansic.pm
	],
	[#Rule inclusiveOrExpression_is_exclusiveOrExpression
		 'inclusive_or_expression', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8885 ./ansic.pm
	],
	[#Rule inclusiveOrExpression_is_inclusiveOrExpression_OR_exclusiveOrExpression
		 'inclusive_or_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8892 ./ansic.pm
	],
	[#Rule logicalAndExpression_is_inclusiveOrExpression
		 'logical_and_expression', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8899 ./ansic.pm
	],
	[#Rule logicalAndExpression_is_logicalAndExpression_AND_OP_inclusiveOrExpression
		 'logical_and_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8906 ./ansic.pm
	],
	[#Rule logicalOrExpression_is_logicalAndExpression
		 'logical_or_expression', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8913 ./ansic.pm
	],
	[#Rule logicalOrExpression_is_logicalOrExpression_OR_OP_logicalAndExpression
		 'logical_or_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8920 ./ansic.pm
	],
	[#Rule conditionalExpression_is_logicalOrExpression
		 'conditional_expression', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8927 ./ansic.pm
	],
	[#Rule conditionalExpression_is_logicalOrExpression_QUESTION_expression_COLON_conditionalExpression
		 'conditional_expression', 5,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8934 ./ansic.pm
	],
	[#Rule assignmentExpression_is_conditionalExpression
		 'assignment_expression', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8941 ./ansic.pm
	],
	[#Rule assignmentExpression_is_unaryExpression_assignmentOperator_assignmentExpression
		 'assignment_expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8948 ./ansic.pm
	],
	[#Rule assignmentOperator_is_ASSIGN
		 'assignment_operator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8955 ./ansic.pm
	],
	[#Rule assignmentOperator_is_MUL_ASSIGN
		 'assignment_operator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8962 ./ansic.pm
	],
	[#Rule assignmentOperator_is_DIV_ASSIGN
		 'assignment_operator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8969 ./ansic.pm
	],
	[#Rule assignmentOperator_is_MOD_ASSIGN
		 'assignment_operator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8976 ./ansic.pm
	],
	[#Rule assignmentOperator_is_ADD_ASSIGN
		 'assignment_operator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8983 ./ansic.pm
	],
	[#Rule assignmentOperator_is_SUB_ASSIGN
		 'assignment_operator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8990 ./ansic.pm
	],
	[#Rule assignmentOperator_is_LEFT_ASSIGN
		 'assignment_operator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 8997 ./ansic.pm
	],
	[#Rule assignmentOperator_is_RIGHT_ASSIGN
		 'assignment_operator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9004 ./ansic.pm
	],
	[#Rule assignmentOperator_is_AND_ASSIGN
		 'assignment_operator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9011 ./ansic.pm
	],
	[#Rule assignmentOperator_is_XOR_ASSIGN
		 'assignment_operator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9018 ./ansic.pm
	],
	[#Rule assignmentOperator_is_OR_ASSIGN
		 'assignment_operator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9025 ./ansic.pm
	],
	[#Rule expression_is_assignmentExpression
		 'expression', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9032 ./ansic.pm
	],
	[#Rule expression_is_expression_COMMA_assignmentExpression
		 'expression', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9039 ./ansic.pm
	],
	[#Rule constantExpression_is_conditionalExpression
		 'constant_expression', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9046 ./ansic.pm
	],
	[#Rule declaration_is_declarationSpecifiers_SC
		 'declaration', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9053 ./ansic.pm
	],
	[#Rule declaration_is_declarationSpecifiers_initDeclaratorList_SC
		 'declaration', 3,
sub {
#line 210 "ansic.eyp"
my $declaration_specifiers = $_[1]; my $init_declarator_list = $_[2]; 
              my $storage_class_specifier =  $declaration_specifiers->child(0);
              if ($storage_class_specifier->child(0)->{token} eq 'TYPEDEF') {

                for my $init_declarator ( $init_declarator_list->Children) {
                  # Get the identifier
                  my $c;
                  for($c = $init_declarator; 
                      $c && !($c->isa('TERMINAL')); 

                      # pointers are prefixes others (arrays, functions) are suffixes
                      $c = ($c->type eq 'declarator_is_pointer_direct_declarator')? $c->child(1) : $c->child(0))
                    {}
                  my $typeid = $c->{attr}[0];
                  $_[0]->{symboltable}{$typeid} = 1;
                  print "\ntypedef definition of $typeid\n";
                }
              }

              goto &Parse::Eyapp::Driver::YYBuildAST;
            }
#line 9080 ./ansic.pm
	],
	[#Rule declarationSpecifiers_is_storageClassSpecifier
		 'declaration_specifiers', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9087 ./ansic.pm
	],
	[#Rule declarationSpecifiers_is_storageClassSpecifier_declarationSpecifiers
		 'declaration_specifiers', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9094 ./ansic.pm
	],
	[#Rule declarationSpecifiers_is_typeSpecifier
		 'declaration_specifiers', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9101 ./ansic.pm
	],
	[#Rule declarationSpecifiers_is_typeSpecifier_declarationSpecifiers
		 'declaration_specifiers', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9108 ./ansic.pm
	],
	[#Rule declarationSpecifiers_is_typeQualifier
		 'declaration_specifiers', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9115 ./ansic.pm
	],
	[#Rule declarationSpecifiers_is_typeQualifier_declarationSpecifiers
		 'declaration_specifiers', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9122 ./ansic.pm
	],
	[#Rule initDeclaratorList_is_initDeclarator
		 'init_declarator_list', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9129 ./ansic.pm
	],
	[#Rule initDeclaratorList_is_initDeclaratorList_COMMA_initDeclarator
		 'init_declarator_list', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9136 ./ansic.pm
	],
	[#Rule initDeclarator_is_declarator
		 'init_declarator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9143 ./ansic.pm
	],
	[#Rule initDeclarator_is_declarator_ASSIGN_initializer
		 'init_declarator', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9150 ./ansic.pm
	],
	[#Rule storageClassSpecifier_is_TYPEDEF
		 'storage_class_specifier', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9157 ./ansic.pm
	],
	[#Rule storageClassSpecifier_is_EXTERN
		 'storage_class_specifier', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9164 ./ansic.pm
	],
	[#Rule storageClassSpecifier_is_STATIC
		 'storage_class_specifier', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9171 ./ansic.pm
	],
	[#Rule storageClassSpecifier_is_AUTO
		 'storage_class_specifier', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9178 ./ansic.pm
	],
	[#Rule storageClassSpecifier_is_REGISTER
		 'storage_class_specifier', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9185 ./ansic.pm
	],
	[#Rule typeSpecifier_is_VOID
		 'type_specifier', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9192 ./ansic.pm
	],
	[#Rule typeSpecifier_is_CHAR
		 'type_specifier', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9199 ./ansic.pm
	],
	[#Rule typeSpecifier_is_SHORT
		 'type_specifier', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9206 ./ansic.pm
	],
	[#Rule typeSpecifier_is_INT
		 'type_specifier', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9213 ./ansic.pm
	],
	[#Rule typeSpecifier_is_LONG
		 'type_specifier', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9220 ./ansic.pm
	],
	[#Rule typeSpecifier_is_FLOAT
		 'type_specifier', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9227 ./ansic.pm
	],
	[#Rule typeSpecifier_is_DOUBLE
		 'type_specifier', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9234 ./ansic.pm
	],
	[#Rule typeSpecifier_is_SIGNED
		 'type_specifier', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9241 ./ansic.pm
	],
	[#Rule typeSpecifier_is_UNSIGNED
		 'type_specifier', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9248 ./ansic.pm
	],
	[#Rule typeSpecifier_is_structOrUnionSpecifier
		 'type_specifier', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9255 ./ansic.pm
	],
	[#Rule typeSpecifier_is_enumSpecifier
		 'type_specifier', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9262 ./ansic.pm
	],
	[#Rule typeSpecifier_is_TYPE_NAME
		 'type_specifier', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9269 ./ansic.pm
	],
	[#Rule structOrUnionSpecifier_is_structOrUnion_IDENTIFIER_OC_structDeclarationList_CC
		 'struct_or_union_specifier', 5,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9276 ./ansic.pm
	],
	[#Rule structOrUnionSpecifier_is_structOrUnion_OC_structDeclarationList_CC
		 'struct_or_union_specifier', 4,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9283 ./ansic.pm
	],
	[#Rule structOrUnionSpecifier_is_structOrUnion_IDENTIFIER
		 'struct_or_union_specifier', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9290 ./ansic.pm
	],
	[#Rule structOrUnion_is_STRUCT
		 'struct_or_union', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9297 ./ansic.pm
	],
	[#Rule structOrUnion_is_UNION
		 'struct_or_union', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9304 ./ansic.pm
	],
	[#Rule structDeclarationList_is_structDeclaration
		 'struct_declaration_list', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9311 ./ansic.pm
	],
	[#Rule structDeclarationList_is_structDeclarationList_structDeclaration
		 'struct_declaration_list', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9318 ./ansic.pm
	],
	[#Rule structDeclaration_is_specifierQualifierList_structDeclaratorList_SC
		 'struct_declaration', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9325 ./ansic.pm
	],
	[#Rule specifierQualifierList_is_typeSpecifier_specifierQualifierList
		 'specifier_qualifier_list', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9332 ./ansic.pm
	],
	[#Rule specifierQualifierList_is_typeSpecifier
		 'specifier_qualifier_list', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9339 ./ansic.pm
	],
	[#Rule specifierQualifierList_is_typeQualifier_specifierQualifierList
		 'specifier_qualifier_list', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9346 ./ansic.pm
	],
	[#Rule specifierQualifierList_is_typeQualifier
		 'specifier_qualifier_list', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9353 ./ansic.pm
	],
	[#Rule structDeclaratorList_is_structDeclarator
		 'struct_declarator_list', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9360 ./ansic.pm
	],
	[#Rule structDeclaratorList_is_structDeclaratorList_COMMA_structDeclarator
		 'struct_declarator_list', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9367 ./ansic.pm
	],
	[#Rule structDeclarator_is_declarator
		 'struct_declarator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9374 ./ansic.pm
	],
	[#Rule structDeclarator_is_COLON_constantExpression
		 'struct_declarator', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9381 ./ansic.pm
	],
	[#Rule structDeclarator_is_declarator_COLON_constantExpression
		 'struct_declarator', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9388 ./ansic.pm
	],
	[#Rule enumSpecifier_is_ENUM_OC_enumeratorList_CC
		 'enum_specifier', 4,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9395 ./ansic.pm
	],
	[#Rule enumSpecifier_is_ENUM_IDENTIFIER_OC_enumeratorList_CC
		 'enum_specifier', 5,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9402 ./ansic.pm
	],
	[#Rule enumSpecifier_is_ENUM_IDENTIFIER
		 'enum_specifier', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9409 ./ansic.pm
	],
	[#Rule enumeratorList_is_enumerator
		 'enumerator_list', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9416 ./ansic.pm
	],
	[#Rule enumeratorList_is_enumeratorList_COMMA_enumerator
		 'enumerator_list', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9423 ./ansic.pm
	],
	[#Rule enumerator_is_IDENTIFIER
		 'enumerator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9430 ./ansic.pm
	],
	[#Rule enumerator_is_IDENTIFIER_ASSIGN_constantExpression
		 'enumerator', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9437 ./ansic.pm
	],
	[#Rule typeQualifier_is_CONST
		 'type_qualifier', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9444 ./ansic.pm
	],
	[#Rule typeQualifier_is_VOLATILE
		 'type_qualifier', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9451 ./ansic.pm
	],
	[#Rule declarator_is_pointer_directDeclarator
		 'declarator', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9458 ./ansic.pm
	],
	[#Rule declarator_is_directDeclarator
		 'declarator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9465 ./ansic.pm
	],
	[#Rule directDeclarator_is_IDENTIFIER
		 'direct_declarator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9472 ./ansic.pm
	],
	[#Rule directDeclarator_is_LP_declarator_RP
		 'direct_declarator', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9479 ./ansic.pm
	],
	[#Rule directDeclarator_is_directDeclarator_LB_constantExpression_RB
		 'direct_declarator', 4,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9486 ./ansic.pm
	],
	[#Rule directDeclarator_is_directDeclarator_LB_RB
		 'direct_declarator', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9493 ./ansic.pm
	],
	[#Rule directDeclarator_is_directDeclarator_LP_parameterTypeList_RP
		 'direct_declarator', 4,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9500 ./ansic.pm
	],
	[#Rule directDeclarator_is_directDeclarator_LP_identifierList_RP
		 'direct_declarator', 4,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9507 ./ansic.pm
	],
	[#Rule directDeclarator_is_directDeclarator_LP_RP
		 'direct_declarator', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9514 ./ansic.pm
	],
	[#Rule pointer_is_STAR
		 'pointer', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9521 ./ansic.pm
	],
	[#Rule pointer_is_STAR_typeQualifierList
		 'pointer', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9528 ./ansic.pm
	],
	[#Rule pointer_is_STAR_pointer
		 'pointer', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9535 ./ansic.pm
	],
	[#Rule pointer_is_STAR_typeQualifierList_pointer
		 'pointer', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9542 ./ansic.pm
	],
	[#Rule typeQualifierList_is_typeQualifier
		 'type_qualifier_list', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9549 ./ansic.pm
	],
	[#Rule typeQualifierList_is_typeQualifierList_typeQualifier
		 'type_qualifier_list', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9556 ./ansic.pm
	],
	[#Rule parameterTypeList_is_parameterList
		 'parameter_type_list', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9563 ./ansic.pm
	],
	[#Rule parameterTypeList_is_parameterList_COMMA_ELLIPSIS
		 'parameter_type_list', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9570 ./ansic.pm
	],
	[#Rule parameterList_is_parameterDeclaration
		 'parameter_list', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9577 ./ansic.pm
	],
	[#Rule parameterList_is_parameterList_COMMA_parameterDeclaration
		 'parameter_list', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9584 ./ansic.pm
	],
	[#Rule parameterDeclaration_is_declarationSpecifiers_declarator
		 'parameter_declaration', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9591 ./ansic.pm
	],
	[#Rule parameterDeclaration_is_declarationSpecifiers_abstractDeclarator
		 'parameter_declaration', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9598 ./ansic.pm
	],
	[#Rule parameterDeclaration_is_declarationSpecifiers
		 'parameter_declaration', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9605 ./ansic.pm
	],
	[#Rule identifierList_is_IDENTIFIER
		 'identifier_list', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9612 ./ansic.pm
	],
	[#Rule identifierList_is_identifierList_COMMA_IDENTIFIER
		 'identifier_list', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9619 ./ansic.pm
	],
	[#Rule typeName_is_specifierQualifierList
		 'type_name', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9626 ./ansic.pm
	],
	[#Rule typeName_is_specifierQualifierList_abstractDeclarator
		 'type_name', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9633 ./ansic.pm
	],
	[#Rule abstractDeclarator_is_pointer
		 'abstract_declarator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9640 ./ansic.pm
	],
	[#Rule abstractDeclarator_is_directAbstractDeclarator
		 'abstract_declarator', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9647 ./ansic.pm
	],
	[#Rule abstractDeclarator_is_pointer_directAbstractDeclarator
		 'abstract_declarator', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9654 ./ansic.pm
	],
	[#Rule directAbstractDeclarator_is_LP_abstractDeclarator_RP
		 'direct_abstract_declarator', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9661 ./ansic.pm
	],
	[#Rule directAbstractDeclarator_is_LB_RB
		 'direct_abstract_declarator', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9668 ./ansic.pm
	],
	[#Rule directAbstractDeclarator_is_LB_constantExpression_RB
		 'direct_abstract_declarator', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9675 ./ansic.pm
	],
	[#Rule directAbstractDeclarator_is_directAbstractDeclarator_LB_RB
		 'direct_abstract_declarator', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9682 ./ansic.pm
	],
	[#Rule directAbstractDeclarator_is_directAbstractDeclarator_LB_constantExpression_RB
		 'direct_abstract_declarator', 4,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9689 ./ansic.pm
	],
	[#Rule directAbstractDeclarator_is_LP_RP
		 'direct_abstract_declarator', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9696 ./ansic.pm
	],
	[#Rule directAbstractDeclarator_is_LP_parameterTypeList_RP
		 'direct_abstract_declarator', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9703 ./ansic.pm
	],
	[#Rule directAbstractDeclarator_is_directAbstractDeclarator_LP_RP
		 'direct_abstract_declarator', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9710 ./ansic.pm
	],
	[#Rule directAbstractDeclarator_is_directAbstractDeclarator_LP_parameterTypeList_RP
		 'direct_abstract_declarator', 4,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9717 ./ansic.pm
	],
	[#Rule initializer_is_assignmentExpression
		 'initializer', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9724 ./ansic.pm
	],
	[#Rule initializer_is_OC_initializerList_CC
		 'initializer', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9731 ./ansic.pm
	],
	[#Rule initializer_is_OC_initializerList_COMMA_CC
		 'initializer', 4,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9738 ./ansic.pm
	],
	[#Rule initializerList_is_initializer
		 'initializer_list', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9745 ./ansic.pm
	],
	[#Rule initializerList_is_initializerList_COMMA_initializer
		 'initializer_list', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9752 ./ansic.pm
	],
	[#Rule statement_is_labeledStatement
		 'statement', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9759 ./ansic.pm
	],
	[#Rule statement_is_compoundStatement
		 'statement', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9766 ./ansic.pm
	],
	[#Rule statement_is_expressionStatement
		 'statement', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9773 ./ansic.pm
	],
	[#Rule statement_is_selectionStatement
		 'statement', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9780 ./ansic.pm
	],
	[#Rule statement_is_iterationStatement
		 'statement', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9787 ./ansic.pm
	],
	[#Rule statement_is_jumpStatement
		 'statement', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9794 ./ansic.pm
	],
	[#Rule labeledStatement_is_IDENTIFIER_COLON_statement
		 'labeled_statement', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9801 ./ansic.pm
	],
	[#Rule labeledStatement_is_CASE_constantExpression_COLON_statement
		 'labeled_statement', 4,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9808 ./ansic.pm
	],
	[#Rule labeledStatement_is_DEFAULT_COLON_statement
		 'labeled_statement', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9815 ./ansic.pm
	],
	[#Rule compoundStatement_is_OC_CC
		 'compound_statement', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9822 ./ansic.pm
	],
	[#Rule compoundStatement_is_OC_statementList_CC
		 'compound_statement', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9829 ./ansic.pm
	],
	[#Rule compoundStatement_is_OC_declarationList_CC
		 'compound_statement', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9836 ./ansic.pm
	],
	[#Rule compoundStatement_is_OC_declarationList_statementList_CC
		 'compound_statement', 4,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9843 ./ansic.pm
	],
	[#Rule declarationList_is_declaration
		 'declaration_list', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9850 ./ansic.pm
	],
	[#Rule declarationList_is_declarationList_declaration
		 'declaration_list', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9857 ./ansic.pm
	],
	[#Rule statementList_is_statement
		 'statement_list', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9864 ./ansic.pm
	],
	[#Rule statementList_is_statementList_statement
		 'statement_list', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9871 ./ansic.pm
	],
	[#Rule expressionStatement_is_SC
		 'expression_statement', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9878 ./ansic.pm
	],
	[#Rule expressionStatement_is_expression_SC
		 'expression_statement', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9885 ./ansic.pm
	],
	[#Rule selectionStatement_is_IF_LP_expression_RP_statement
		 'selection_statement', 5,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9892 ./ansic.pm
	],
	[#Rule selectionStatement_is_IF_LP_expression_RP_statement_ELSE_statement
		 'selection_statement', 7,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9899 ./ansic.pm
	],
	[#Rule selectionStatement_is_SWITCH_LP_expression_RP_statement
		 'selection_statement', 5,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9906 ./ansic.pm
	],
	[#Rule iterationStatement_is_WHILE_LP_expression_RP_statement
		 'iteration_statement', 5,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9913 ./ansic.pm
	],
	[#Rule iterationStatement_is_DO_statement_WHILE_LP_expression_RP_SC
		 'iteration_statement', 7,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9920 ./ansic.pm
	],
	[#Rule iterationStatement_is_FOR_LP_expressionStatement_expressionStatement_RP_statement
		 'iteration_statement', 6,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9927 ./ansic.pm
	],
	[#Rule iterationStatement_is_FOR_LP_expressionStatement_expressionStatement_expression_RP_statement
		 'iteration_statement', 7,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9934 ./ansic.pm
	],
	[#Rule jumpStatement_is_GOTO_IDENTIFIER_SC
		 'jump_statement', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9941 ./ansic.pm
	],
	[#Rule jumpStatement_is_CONTINUE_SC
		 'jump_statement', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9948 ./ansic.pm
	],
	[#Rule jumpStatement_is_BREAK_SC
		 'jump_statement', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9955 ./ansic.pm
	],
	[#Rule jumpStatement_is_RETURN_SC
		 'jump_statement', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9962 ./ansic.pm
	],
	[#Rule jumpStatement_is_RETURN_expression_SC
		 'jump_statement', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9969 ./ansic.pm
	],
	[#Rule translationUnit_is_externalDeclaration
		 'translation_unit', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9976 ./ansic.pm
	],
	[#Rule translationUnit_is_translationUnit_externalDeclaration
		 'translation_unit', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9983 ./ansic.pm
	],
	[#Rule externalDeclaration_is_functionDefinition
		 'external_declaration', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9990 ./ansic.pm
	],
	[#Rule externalDeclaration_is_declaration
		 'external_declaration', 1,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 9997 ./ansic.pm
	],
	[#Rule functionDefinition_is_declarationSpecifiers_declarator_declarationList_compoundStatement
		 'function_definition', 4,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 10004 ./ansic.pm
	],
	[#Rule functionDefinition_is_declarationSpecifiers_declarator_compoundStatement
		 'function_definition', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 10011 ./ansic.pm
	],
	[#Rule functionDefinition_is_declarator_declarationList_compoundStatement
		 'function_definition', 3,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 10018 ./ansic.pm
	],
	[#Rule functionDefinition_is_declarator_compoundStatement
		 'function_definition', 2,
sub {
#line 26 "ansic.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 10025 ./ansic.pm
	]
],
#line 10028 ./ansic.pm
    yybypass       => 0,
    yybuildingtree => 1,
    yyprefix       => '',
    yyaccessors    => {
   },
    yyconflicthandlers => {}
,
    yystateconflict => {  },
    @_,
  );
  bless($self,$class);

  $self->make_node_classes('TERMINAL', '_OPTIONAL', '_STAR_LIST', '_PLUS_LIST', 
         '_SUPERSTART', 
         'primaryExpression_is_IDENTIFIER', 
         'primaryExpression_is_CONSTANT', 
         'primaryExpression_is_STRING_LITERAL', 
         'primaryExpression_is_LP_expression_RP', 
         'postfixExpression_is_primaryExpression', 
         'postfixExpression_is_postfixExpression_LB_expression_RB', 
         'postfixExpression_is_postfixExpression_LP_RP', 
         'postfixExpression_is_postfixExpression_LP_argumentExpressionList_RP', 
         'postfixExpression_is_postfixExpression_DOT_IDENTIFIER', 
         'postfixExpression_is_postfixExpression_PTR_OP_IDENTIFIER', 
         'postfixExpression_is_postfixExpression_INC_OP', 
         'postfixExpression_is_postfixExpression_DEC_OP', 
         'argumentExpressionList_is_assignmentExpression', 
         'argumentExpressionList_is_argumentExpressionList_COMMA_assignmentExpression', 
         'unaryExpression_is_postfixExpression', 
         'unaryExpression_is_INC_OP_unaryExpression', 
         'unaryExpression_is_DEC_OP_unaryExpression', 
         'unaryExpression_is_unaryOperator_castExpression', 
         'unaryExpression_is_SIZEOF_unaryExpression', 
         'unaryExpression_is_SIZEOF_LP_typeName_RP', 
         'unaryOperator_is_AMP', 
         'unaryOperator_is_STAR', 
         'unaryOperator_is_PLUS', 
         'unaryOperator_is_MINUS', 
         'unaryOperator_is_BNOT', 
         'unaryOperator_is_NOT', 
         'castExpression_is_unaryExpression', 
         'castExpression_is_LP_typeName_RP_castExpression', 
         'multiplicativeExpression_is_castExpression', 
         'multiplicativeExpression_is_multiplicativeExpression_STAR_castExpression', 
         'multiplicativeExpression_is_multiplicativeExpression_DIV_castExpression', 
         'multiplicativeExpression_is_multiplicativeExpression_PERCENT_castExpression', 
         'additiveExpression_is_multiplicativeExpression', 
         'additiveExpression_is_additiveExpression_PLUS_multiplicativeExpression', 
         'additiveExpression_is_additiveExpression_MINUS_multiplicativeExpression', 
         'shiftExpression_is_additiveExpression', 
         'shiftExpression_is_shiftExpression_LEFT_OP_additiveExpression', 
         'shiftExpression_is_shiftExpression_RIGHT_OP_additiveExpression', 
         'relationalExpression_is_shiftExpression', 
         'relationalExpression_is_relationalExpression_LT_shiftExpression', 
         'relationalExpression_is_relationalExpression_GT_shiftExpression', 
         'relationalExpression_is_relationalExpression_LE_OP_shiftExpression', 
         'relationalExpression_is_relationalExpression_GE_OP_shiftExpression', 
         'equalityExpression_is_relationalExpression', 
         'equalityExpression_is_equalityExpression_EQ_OP_relationalExpression', 
         'equalityExpression_is_equalityExpression_NE_OP_relationalExpression', 
         'andExpression_is_equalityExpression', 
         'andExpression_is_andExpression_AMP_equalityExpression', 
         'exclusiveOrExpression_is_andExpression', 
         'exclusiveOrExpression_is_exclusiveOrExpression_XOR_andExpression', 
         'inclusiveOrExpression_is_exclusiveOrExpression', 
         'inclusiveOrExpression_is_inclusiveOrExpression_OR_exclusiveOrExpression', 
         'logicalAndExpression_is_inclusiveOrExpression', 
         'logicalAndExpression_is_logicalAndExpression_AND_OP_inclusiveOrExpression', 
         'logicalOrExpression_is_logicalAndExpression', 
         'logicalOrExpression_is_logicalOrExpression_OR_OP_logicalAndExpression', 
         'conditionalExpression_is_logicalOrExpression', 
         'conditionalExpression_is_logicalOrExpression_QUESTION_expression_COLON_conditionalExpression', 
         'assignmentExpression_is_conditionalExpression', 
         'assignmentExpression_is_unaryExpression_assignmentOperator_assignmentExpression', 
         'assignmentOperator_is_ASSIGN', 
         'assignmentOperator_is_MUL_ASSIGN', 
         'assignmentOperator_is_DIV_ASSIGN', 
         'assignmentOperator_is_MOD_ASSIGN', 
         'assignmentOperator_is_ADD_ASSIGN', 
         'assignmentOperator_is_SUB_ASSIGN', 
         'assignmentOperator_is_LEFT_ASSIGN', 
         'assignmentOperator_is_RIGHT_ASSIGN', 
         'assignmentOperator_is_AND_ASSIGN', 
         'assignmentOperator_is_XOR_ASSIGN', 
         'assignmentOperator_is_OR_ASSIGN', 
         'expression_is_assignmentExpression', 
         'expression_is_expression_COMMA_assignmentExpression', 
         'constantExpression_is_conditionalExpression', 
         'declaration_is_declarationSpecifiers_SC', 
         'declaration_is_declarationSpecifiers_initDeclaratorList_SC', 
         'declarationSpecifiers_is_storageClassSpecifier', 
         'declarationSpecifiers_is_storageClassSpecifier_declarationSpecifiers', 
         'declarationSpecifiers_is_typeSpecifier', 
         'declarationSpecifiers_is_typeSpecifier_declarationSpecifiers', 
         'declarationSpecifiers_is_typeQualifier', 
         'declarationSpecifiers_is_typeQualifier_declarationSpecifiers', 
         'initDeclaratorList_is_initDeclarator', 
         'initDeclaratorList_is_initDeclaratorList_COMMA_initDeclarator', 
         'initDeclarator_is_declarator', 
         'initDeclarator_is_declarator_ASSIGN_initializer', 
         'storageClassSpecifier_is_TYPEDEF', 
         'storageClassSpecifier_is_EXTERN', 
         'storageClassSpecifier_is_STATIC', 
         'storageClassSpecifier_is_AUTO', 
         'storageClassSpecifier_is_REGISTER', 
         'typeSpecifier_is_VOID', 
         'typeSpecifier_is_CHAR', 
         'typeSpecifier_is_SHORT', 
         'typeSpecifier_is_INT', 
         'typeSpecifier_is_LONG', 
         'typeSpecifier_is_FLOAT', 
         'typeSpecifier_is_DOUBLE', 
         'typeSpecifier_is_SIGNED', 
         'typeSpecifier_is_UNSIGNED', 
         'typeSpecifier_is_structOrUnionSpecifier', 
         'typeSpecifier_is_enumSpecifier', 
         'typeSpecifier_is_TYPE_NAME', 
         'structOrUnionSpecifier_is_structOrUnion_IDENTIFIER_OC_structDeclarationList_CC', 
         'structOrUnionSpecifier_is_structOrUnion_OC_structDeclarationList_CC', 
         'structOrUnionSpecifier_is_structOrUnion_IDENTIFIER', 
         'structOrUnion_is_STRUCT', 
         'structOrUnion_is_UNION', 
         'structDeclarationList_is_structDeclaration', 
         'structDeclarationList_is_structDeclarationList_structDeclaration', 
         'structDeclaration_is_specifierQualifierList_structDeclaratorList_SC', 
         'specifierQualifierList_is_typeSpecifier_specifierQualifierList', 
         'specifierQualifierList_is_typeSpecifier', 
         'specifierQualifierList_is_typeQualifier_specifierQualifierList', 
         'specifierQualifierList_is_typeQualifier', 
         'structDeclaratorList_is_structDeclarator', 
         'structDeclaratorList_is_structDeclaratorList_COMMA_structDeclarator', 
         'structDeclarator_is_declarator', 
         'structDeclarator_is_COLON_constantExpression', 
         'structDeclarator_is_declarator_COLON_constantExpression', 
         'enumSpecifier_is_ENUM_OC_enumeratorList_CC', 
         'enumSpecifier_is_ENUM_IDENTIFIER_OC_enumeratorList_CC', 
         'enumSpecifier_is_ENUM_IDENTIFIER', 
         'enumeratorList_is_enumerator', 
         'enumeratorList_is_enumeratorList_COMMA_enumerator', 
         'enumerator_is_IDENTIFIER', 
         'enumerator_is_IDENTIFIER_ASSIGN_constantExpression', 
         'typeQualifier_is_CONST', 
         'typeQualifier_is_VOLATILE', 
         'declarator_is_pointer_directDeclarator', 
         'declarator_is_directDeclarator', 
         'directDeclarator_is_IDENTIFIER', 
         'directDeclarator_is_LP_declarator_RP', 
         'directDeclarator_is_directDeclarator_LB_constantExpression_RB', 
         'directDeclarator_is_directDeclarator_LB_RB', 
         'directDeclarator_is_directDeclarator_LP_parameterTypeList_RP', 
         'directDeclarator_is_directDeclarator_LP_identifierList_RP', 
         'directDeclarator_is_directDeclarator_LP_RP', 
         'pointer_is_STAR', 
         'pointer_is_STAR_typeQualifierList', 
         'pointer_is_STAR_pointer', 
         'pointer_is_STAR_typeQualifierList_pointer', 
         'typeQualifierList_is_typeQualifier', 
         'typeQualifierList_is_typeQualifierList_typeQualifier', 
         'parameterTypeList_is_parameterList', 
         'parameterTypeList_is_parameterList_COMMA_ELLIPSIS', 
         'parameterList_is_parameterDeclaration', 
         'parameterList_is_parameterList_COMMA_parameterDeclaration', 
         'parameterDeclaration_is_declarationSpecifiers_declarator', 
         'parameterDeclaration_is_declarationSpecifiers_abstractDeclarator', 
         'parameterDeclaration_is_declarationSpecifiers', 
         'identifierList_is_IDENTIFIER', 
         'identifierList_is_identifierList_COMMA_IDENTIFIER', 
         'typeName_is_specifierQualifierList', 
         'typeName_is_specifierQualifierList_abstractDeclarator', 
         'abstractDeclarator_is_pointer', 
         'abstractDeclarator_is_directAbstractDeclarator', 
         'abstractDeclarator_is_pointer_directAbstractDeclarator', 
         'directAbstractDeclarator_is_LP_abstractDeclarator_RP', 
         'directAbstractDeclarator_is_LB_RB', 
         'directAbstractDeclarator_is_LB_constantExpression_RB', 
         'directAbstractDeclarator_is_directAbstractDeclarator_LB_RB', 
         'directAbstractDeclarator_is_directAbstractDeclarator_LB_constantExpression_RB', 
         'directAbstractDeclarator_is_LP_RP', 
         'directAbstractDeclarator_is_LP_parameterTypeList_RP', 
         'directAbstractDeclarator_is_directAbstractDeclarator_LP_RP', 
         'directAbstractDeclarator_is_directAbstractDeclarator_LP_parameterTypeList_RP', 
         'initializer_is_assignmentExpression', 
         'initializer_is_OC_initializerList_CC', 
         'initializer_is_OC_initializerList_COMMA_CC', 
         'initializerList_is_initializer', 
         'initializerList_is_initializerList_COMMA_initializer', 
         'statement_is_labeledStatement', 
         'statement_is_compoundStatement', 
         'statement_is_expressionStatement', 
         'statement_is_selectionStatement', 
         'statement_is_iterationStatement', 
         'statement_is_jumpStatement', 
         'labeledStatement_is_IDENTIFIER_COLON_statement', 
         'labeledStatement_is_CASE_constantExpression_COLON_statement', 
         'labeledStatement_is_DEFAULT_COLON_statement', 
         'compoundStatement_is_OC_CC', 
         'compoundStatement_is_OC_statementList_CC', 
         'compoundStatement_is_OC_declarationList_CC', 
         'compoundStatement_is_OC_declarationList_statementList_CC', 
         'declarationList_is_declaration', 
         'declarationList_is_declarationList_declaration', 
         'statementList_is_statement', 
         'statementList_is_statementList_statement', 
         'expressionStatement_is_SC', 
         'expressionStatement_is_expression_SC', 
         'selectionStatement_is_IF_LP_expression_RP_statement', 
         'selectionStatement_is_IF_LP_expression_RP_statement_ELSE_statement', 
         'selectionStatement_is_SWITCH_LP_expression_RP_statement', 
         'iterationStatement_is_WHILE_LP_expression_RP_statement', 
         'iterationStatement_is_DO_statement_WHILE_LP_expression_RP_SC', 
         'iterationStatement_is_FOR_LP_expressionStatement_expressionStatement_RP_statement', 
         'iterationStatement_is_FOR_LP_expressionStatement_expressionStatement_expression_RP_statement', 
         'jumpStatement_is_GOTO_IDENTIFIER_SC', 
         'jumpStatement_is_CONTINUE_SC', 
         'jumpStatement_is_BREAK_SC', 
         'jumpStatement_is_RETURN_SC', 
         'jumpStatement_is_RETURN_expression_SC', 
         'translationUnit_is_externalDeclaration', 
         'translationUnit_is_translationUnit_externalDeclaration', 
         'externalDeclaration_is_functionDefinition', 
         'externalDeclaration_is_declaration', 
         'functionDefinition_is_declarationSpecifiers_declarator_declarationList_compoundStatement', 
         'functionDefinition_is_declarationSpecifiers_declarator_compoundStatement', 
         'functionDefinition_is_declarator_declarationList_compoundStatement', 
         'functionDefinition_is_declarator_compoundStatement', );
  $self;
}

#line 492 "ansic.eyp"


use Carp;
use Getopt::Long;

my %keywords = (
  auto => 'AUTO',
  break => 'BREAK',
  case => 'CASE',
  char => 'CHAR',
  const => 'CONST',
  continue => 'CONTINUE',
  default => 'DEFAULT',
  do => 'DO',
  double => 'DOUBLE',
  else => 'ELSE',
  enum => 'ENUM',
  extern => 'EXTERN',
  float => 'FLOAT',
  for => 'FOR',
  goto => 'GOTO',
  if => 'IF',
  int => 'INT',
  long => 'LONG',
  register => 'REGISTER',
  return => 'RETURN',
  short => 'SHORT',
  signed => 'SIGNED',
  sizeof => 'SIZEOF',
  static => 'STATIC',
  struct => 'STRUCT',
  switch => 'SWITCH',
  typedef => 'TYPEDEF',
  union => 'UNION',
  unsigned => 'UNSIGNED',
  void => 'VOID',
  volatile => 'VOLATILE',
  while => 'WHILE',
);

my %lexeme = (
  '...' => 'ELLIPSIS',
  '>>=' => 'RIGHT_ASSIGN',
  '<<=' => 'LEFT_ASSIGN',
  '+=' => 'ADD_ASSIGN',
  '-=' => 'SUB_ASSIGN',
  '*=' => 'MUL_ASSIGN',
  '/=' => 'DIV_ASSIGN',
  '%=' => 'MOD_ASSIGN',
  '&=' => 'AND_ASSIGN',
  '^=' => 'XOR_ASSIGN',
  '|=' => 'OR_ASSIGN',
  '>>' => 'RIGHT_OP',
  '<<' => 'LEFT_OP',
  '++' => 'INC_OP',
  '--' => 'DEC_OP',
  '->' => 'PTR_OP',
  '&&' => 'AND_OP',
  '||' => 'OR_OP',
  '<=' => 'LE_OP',
  '>=' => 'GE_OP',
  '==' => 'EQ_OP',
  '!=' => 'NE_OP',
  ';' => ';',
  "{" => '{',
  "<%" => '{',
  "}" => '}',
  "%>" => '}',
  ',' => ',',
  ':' => ':',
  '=' => '=',
  '(' => '(',
  ')' => ')',
  "[" => '[',
  "<:" => '[',
  "]" => ']',
  ":>" => ']',
  '.' => '.',
  '&' => '&',
  '!' => '!',
  '~' => '~',
  '-' => '-',
  '+' => '+',
  '*' => '*',
  '/' => '/',
  '%' => '%',
  '<' => '<',
  '>' => '>',
  '^' => '^',
  '|' => '|',
  '?' => '?',
);

my ($tokenbegin, $tokenend) = (1, 1);

sub _Lexer {
  my($parser)=shift;

  my $token;
  for ($parser->{INPUT}) {
      return('',undef) if !defined($_) or $_ eq '';

      #Skip blanks
      s{\A
         ((?:
              \s+       # any white space char
          |   /\*.*?\*/ # C like comments
          |   //[^\n]*  # C++ like comments
          )+
         )
       }
       {}xs
      and do {
            my($blanks)=$1;

            #Maybe At EOF
            return('', undef) if $_ eq '';
            $tokenend += $blanks =~ tr/\n//;
        };

     $tokenbegin = $tokenend;

      s{^(L?\"(\\.|[^\\"])*\")}{}    
              and return('STRING_LITERAL', [$1, $tokenbegin]);

      s{^(
            0[xX][0-9a-fA-F]+[uUlL]? # hexadecimal
          | 0\d+[uUlL]?              # octal
          | \d*\.\d+([Ee][+-]?\d+)?[fFlL]? # float
          | \d+\.\d*([Ee][+-]?\d+)?[fFlL]? # float
          | \d+[Ee][+-]?\d+[fFlL]?   # decimal/float with exp
          | \d+[uUlL]?               # decimal
          | L?'(\\.|[^\\'])+'        # string
         )
       }
       {}x
              and return('CONSTANT',[$1, $tokenbegin]);

      #s/^([A-Z][A-Za-z0-9_]*)//
      #  and do {
      #    my $word = $1;
      #    return('TYPE_NAME',[$word, $tokenbegin]);
      #};

      s/^([a-zA-Z_][A-Za-z0-9_]*)//
        and do {
          my $word = $1;
          my $r;
          return ($r, [$r, $tokenbegin]) if defined($r = $keywords{$word});
          return('TYPE_NAME',[$word, $tokenbegin]) if $parser->{symboltable}{$word};
          return('IDENTIFIER',[$word, $tokenbegin]);
      };

      m/^(\S\S\S)/ and  defined($token = $1) and exists($lexeme{$token})
        and do {
          s/...//;
          return ($lexeme{$token}, [$token, $tokenbegin]);
        }; # do

      m/^(\S\S)/ and  defined($token = $1) and exists($lexeme{$token})
        and do {
          s/..//;
          return ($lexeme{$token}, [$token, $tokenbegin]);
        }; # do

      m/^(\S)/ and defined($token = $1) and  exists($lexeme{$token})
        and do {
          s/.//;
          return ($lexeme{$token}, [$token, $tokenbegin]);
        }; # do
      

      die "Unexpected character at $tokenbegin\n";
  } # for
}

sub _Error {
  my($token)=$_[0]->YYCurval;
  my($what)= $token ? "input: '$token->[0]' in line $token->[1]" : "end of input";
  my @expected = $_[0]->YYExpect();
  my $expected = @expected? "Expected one of these tokens: '@expected'":"";

  croak "Syntax error near $what. $expected\n";
}

sub Run {
    my($self)=shift;
    my $yydebug = shift || 0;

    return $self->YYParse( 
      yylex => \&_Lexer, 
      yyerror => \&_Error,
      yydebug => $yydebug, # 0x1F
    );
}

sub uploadfile {
  my $file = shift;
  my $msg = shift;

  my $input = '';
  eval {
    $input = Parse::Eyapp::Base::slurp_file($file) 
  };
  if ($@) {
    print $msg;
    local $/ = undef;
    $input = <STDIN>;
  }
  return $input;
}

sub main {
  my $package = shift;

  my $debug = 0;
  my $file = '';
  my $result = GetOptions (
    "debug!" => \$debug,  
    "file=s" => \$file,
  );

  $debug = 0x1F if $debug;
  $file = shift if !$file && @ARGV; 

  my $parser = $package->new();
  my $prompt = "Expressions. Press CTRL-D (Unix) or CTRL-Z (Windows) to finish:\n";
  $parser->{INPUT} = uploadfile($file, $prompt);
  $Parse::Eyapp::Node::INDENT = 2;

  print "\n******************************************************************\n";
  print $parser->Run( $debug )->str,"\n";
}

sub TERMINAL::info {
  $_[0]->{attr}[0]
};

__PACKAGE__->main unless caller();


=head1 NAME ANSIC eyapp grammar and parser

=head1 SYNOPSIS

Compile it with:

  $ eyapp -b '' ansic.eyp

Run it with:

  $ ansic.pm -file program.c -debug

or, if you don't want debug info:

  $ ansic.pm -file typedefstruct.c

=head1 DESCRIPTION

Scope and type analysis is not implemented (yet). Typedefs have global scope
and can not be hidden by later declarations.
I.e. the parser produces an error message for the following program:

  typedef int A;
  A A;

since it interprets the Third C<A> as a type name.

=head1 SEE ALSO

=over 2

=item * L<http://www.lysator.liu.se/c/ANSI-C-grammar-y.html>

=item * L<http://cs.tu-berlin.de/~jutta/c/ANSI-C-grammar-l.html>

=item * L<http://frama-c.cea.fr/download/acsl_1.2.pdf>

=item * L<http://www.open-std.org/JTC1/SC22/WG14/www/standards>

=item * L<http://www.open-std.org/JTC1/SC22/WG14/www/docs/n1256.pdf>


=back

=head1 AUTHOR 
 
Casiano Rodriguez-Leon (casiano@ull.es)

=head1 LICENCE AND COPYRIGHT
 
Copyright (c) 2006-2008 Casiano Rodriguez-Leon (casiano@ull.es). All rights reserved.

These modules are free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.
 
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 




=cut




#line 10566 ./ansic.pm



1;
