#!/usr/bin/perl
########################################################################################
#
#    This file was generated using Parse::Eyapp version 1.152.
#
# (c) Parse::Yapp Copyright 1998-2001 Francois Desarmenien.
# (c) Parse::Eyapp Copyright 2006-2008 Casiano Rodriguez-Leon. Universidad de La Laguna.
#        Don't edit this file, use source file 'PIR.eyp' instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
########################################################################################
package PIR;
use strict;

push @PIR::ISA, 'Parse::Eyapp::Driver';


BEGIN {
  # This strange way to load the modules is to guarantee compatibility when
  # using several standalone and non-standalone Eyapp parsers

  require Parse::Eyapp::Driver unless Parse::Eyapp::Driver->can('YYParse');
  require Parse::Eyapp::Node unless Parse::Eyapp::Node->can('hnew'); 
}
  

#line 86 "PIR.eyp"

my $LETTER           = qr{[a-zA-Z_\@]};
my $DIGIT            = qr{[0-9]};
my $DIGITS           = qr{(?:$DIGIT)+};
my $HEX              = qr{0[xX][0-9A-Fa-f]+};
my $OCT              = qr{0[oO][0-7]+};
my $BIN              = qr{0[bB][01]+};
my $DOT              = qr{[.]};
my $SIGN             = qr{[-+]};
my $BIGINT           = qr{(?:$SIGN)?$DIGITS"L"};
my $FLOATNUM         = qr{(?:$SIGN)?(?:(?:$DIGITS$DOT(?:$DIGIT)*|$DOT$DIGITS)(?:[eE](?:$SIGN)?$DIGITS)?|$DIGITS[eE](?:$SIGN)?$DIGITS)};
my $LETTERDIGIT      = qr{[a-zA-Z0-9_]};
my $LABELLETTERDIGIT = qr{(?:[a-zA-Z0-9_@])};
my $ID               = qr{$LETTER(?:$LABELLETTERDIGIT)*};
my $DQ_STRING        = qr{\"(?:\\.|[^"\\\n])*\"};
my $ENCCHAR          = qr{$LETTER|$DIGIT|"-"};
my $ENCCHARS         = qr{(?:$ENCCHAR)*};
my $ENC              = qr{$LETTER$ENCCHARS":"};
my $UNICODE          = qr{$ENC(?:$ENC)?$DQ_STRING};
my $SQ_STRING        = qr{\'[^'\n]*\'};
my $STRINGCONSTANT   = qr{$SQ_STRING|$DQ_STRING};
my $RANKSPEC         = qr{\[[,]*\]};
my $EOL              = qr{\r?\n};
my $WS               = qr{[\t\f\r\x1a ]};
my $SP               = qr{[ ]};

#line 54 ./PIR.pm

my $warnmessage =<< "EOFWARN";
Warning!: Did you changed the \@PIR::ISA variable inside the header section of the eyapp program?
EOFWARN

sub new {
  my($class)=shift;
  ref($class) and $class=ref($class);

  warn $warnmessage unless __PACKAGE__->isa('Parse::Eyapp::Driver'); 
  my($self)=$class->SUPER::new( 
    yyversion => '1.152',
    yyGRAMMAR  =>
[
  [ '_SUPERSTART' => '$start', [ 'program', '$end' ], 0 ],
  [ 'program_1' => 'program', [ 'compilation_units' ], 0 ],
  [ 'compilation_units_2' => 'compilation_units', [ 'compilation_unit' ], 0 ],
  [ 'compilation_units_3' => 'compilation_units', [ 'compilation_units', 'compilation_unit' ], 0 ],
  [ 'compilation_unit_4' => 'compilation_unit', [ 'class_namespace' ], 0 ],
  [ 'compilation_unit_5' => 'compilation_unit', [ 'constdef' ], 0 ],
  [ 'compilation_unit_6' => 'compilation_unit', [ 'sub' ], 0 ],
  [ 'compilation_unit_7' => 'compilation_unit', [ 'emit' ], 0 ],
  [ 'compilation_unit_8' => 'compilation_unit', [ 'MACRO', '\n' ], 0 ],
  [ 'compilation_unit_9' => 'compilation_unit', [ 'pragma' ], 0 ],
  [ 'compilation_unit_10' => 'compilation_unit', [ 'location_directive' ], 0 ],
  [ 'compilation_unit_11' => 'compilation_unit', [ '\n' ], 0 ],
  [ 'pragma_12' => 'pragma', [ 'hll_def', '\n' ], 0 ],
  [ 'pragma_13' => 'pragma', [ 'LOADLIB', 'STRINGC', '\n' ], 0 ],
  [ 'location_directive_14' => 'location_directive', [ 'TK_LINE', 'INTC', 'COMMA', 'STRINGC', '\n' ], 0 ],
  [ 'location_directive_15' => 'location_directive', [ 'TK_FILE', 'STRINGC', '\n' ], 0 ],
  [ 'annotate_directive_16' => 'annotate_directive', [ 'ANNOTATE', 'STRINGC', 'COMMA', 'const' ], 0 ],
  [ 'hll_def_17' => 'hll_def', [ 'HLL', 'STRINGC' ], 0 ],
  [ 'constdef_18' => 'constdef', [ 'CONST', 'type', 'IDENTIFIER', '=', 'const' ], 0 ],
  [ 'pmc_const_19' => 'pmc_const', [ 'CONST', 'INTC', 'var_or_i', '=', 'any_string' ], 0 ],
  [ 'pmc_const_20' => 'pmc_const', [ 'CONST', 'STRINGC', 'var_or_i', '=', 'any_string' ], 0 ],
  [ 'any_string_21' => 'any_string', [ 'STRINGC' ], 0 ],
  [ 'any_string_22' => 'any_string', [ 'USTRINGC' ], 0 ],
  [ 'pasmcode_23' => 'pasmcode', [ 'pasmline' ], 0 ],
  [ 'pasmcode_24' => 'pasmcode', [ 'pasmcode', 'pasmline' ], 0 ],
  [ 'pasmline_25' => 'pasmline', [ 'labels', 'pasm_inst', '\n' ], 0 ],
  [ 'pasmline_26' => 'pasmline', [ 'MACRO', '\n' ], 0 ],
  [ 'pasmline_27' => 'pasmline', [ 'FILECOMMENT' ], 0 ],
  [ 'pasmline_28' => 'pasmline', [ 'LINECOMMENT' ], 0 ],
  [ 'pasmline_29' => 'pasmline', [ 'class_namespace' ], 0 ],
  [ 'pasmline_30' => 'pasmline', [ 'pmc_const' ], 0 ],
  [ 'pasmline_31' => 'pasmline', [ 'pragma' ], 0 ],
  [ 'pasm_inst_32' => 'pasm_inst', [ 'PARROT_OP', 'pasm_args' ], 0 ],
  [ 'pasm_inst_33' => 'pasm_inst', [ 'PCC_SUB', 'sub_proto', 'LABEL' ], 0 ],
  [ 'pasm_inst_34' => 'pasm_inst', [ 'PNULL', 'var' ], 0 ],
  [ 'pasm_inst_35' => 'pasm_inst', [ 'LEXICAL', 'STRINGC', 'COMMA', 'REG' ], 0 ],
  [ 'pasm_inst_36' => 'pasm_inst', [  ], 0 ],
  [ 'pasm_args_37' => 'pasm_args', [ 'vars' ], 0 ],
  [ 'emit_38' => 'emit', [ 'EMIT', 'opt_pasmcode', 'EOM' ], 0 ],
  [ 'opt_pasmcode_39' => 'opt_pasmcode', [  ], 0 ],
  [ 'opt_pasmcode_40' => 'opt_pasmcode', [ 'pasmcode' ], 0 ],
  [ 'class_namespace_41' => 'class_namespace', [ 'NAMESPACE', 'maybe_ns', '\n' ], 0 ],
  [ 'maybe_ns_42' => 'maybe_ns', [ '[', 'keylist', ']' ], 0 ],
  [ 'maybe_ns_43' => 'maybe_ns', [ '[', ']' ], 0 ],
  [ 'sub_44' => 'sub', [ 'SUB', 'sub_label_op_c', 'sub_proto', '\n', 'sub_params', 'sub_body', 'ESUB' ], 0 ],
  [ 'sub_params_45' => 'sub_params', [  ], 0 ],
  [ 'sub_params_46' => 'sub_params', [ '\n' ], 0 ],
  [ 'sub_params_47' => 'sub_params', [ 'sub_params', 'sub_param', '\n' ], 0 ],
  [ 'sub_param_48' => 'sub_param', [ 'PARAM', 'sub_param_type_def' ], 0 ],
  [ 'sub_param_type_def_49' => 'sub_param_type_def', [ 'type', 'IDENTIFIER', 'paramtype_list' ], 0 ],
  [ 'multi_50' => 'multi', [ 'MULTI', '(', 'multi_types', ')' ], 0 ],
  [ 'outer_51' => 'outer', [ 'OUTER', '(', 'STRINGC', ')' ], 0 ],
  [ 'outer_52' => 'outer', [ 'OUTER', '(', 'IDENTIFIER', ')' ], 0 ],
  [ 'vtable_53' => 'vtable', [ 'VTABLE_METHOD' ], 0 ],
  [ 'vtable_54' => 'vtable', [ 'VTABLE_METHOD', '(', 'STRINGC', ')' ], 0 ],
  [ 'method_55' => 'method', [ 'METHOD' ], 0 ],
  [ 'method_56' => 'method', [ 'METHOD', '(', 'any_string', ')' ], 0 ],
  [ 'ns_entry_name_57' => 'ns_entry_name', [ 'NS_ENTRY' ], 0 ],
  [ 'ns_entry_name_58' => 'ns_entry_name', [ 'NS_ENTRY', '(', 'any_string', ')' ], 0 ],
  [ 'instanceof_59' => 'instanceof', [ 'SUB_INSTANCE_OF', '(', 'STRINGC', ')' ], 0 ],
  [ 'subid_60' => 'subid', [ 'SUBID' ], 0 ],
  [ 'subid_61' => 'subid', [ 'SUBID', '(', 'any_string', ')' ], 0 ],
  [ 'multi_types_62' => 'multi_types', [  ], 0 ],
  [ 'multi_types_63' => 'multi_types', [ 'multi_types', 'COMMA', 'multi_type' ], 0 ],
  [ 'multi_types_64' => 'multi_types', [ 'multi_type' ], 0 ],
  [ 'multi_type_65' => 'multi_type', [ 'INTV' ], 0 ],
  [ 'multi_type_66' => 'multi_type', [ 'FLOATV' ], 0 ],
  [ 'multi_type_67' => 'multi_type', [ 'PMCV' ], 0 ],
  [ 'multi_type_68' => 'multi_type', [ 'STRINGV' ], 0 ],
  [ 'multi_type_69' => 'multi_type', [ 'IDENTIFIER' ], 0 ],
  [ 'multi_type_70' => 'multi_type', [ 'STRINGC' ], 0 ],
  [ 'multi_type_71' => 'multi_type', [ '[', 'keylist', ']' ], 0 ],
  [ 'sub_body_72' => 'sub_body', [  ], 0 ],
  [ 'sub_body_73' => 'sub_body', [ 'statements' ], 0 ],
  [ 'pcc_sub_call_74' => 'pcc_sub_call', [ 'PCC_BEGIN', '\n', 'pcc_args', 'opt_invocant', 'pcc_call', 'opt_label', 'pcc_results', 'PCC_END' ], 0 ],
  [ 'opt_label_75' => 'opt_label', [  ], 0 ],
  [ 'opt_label_76' => 'opt_label', [ 'label', '\n' ], 0 ],
  [ 'opt_invocant_77' => 'opt_invocant', [  ], 0 ],
  [ 'opt_invocant_78' => 'opt_invocant', [ 'INVOCANT', 'var', '\n' ], 0 ],
  [ 'sub_proto_79' => 'sub_proto', [  ], 0 ],
  [ 'sub_proto_80' => 'sub_proto', [ 'sub_proto_list' ], 0 ],
  [ 'sub_proto_list_81' => 'sub_proto_list', [ 'proto' ], 0 ],
  [ 'sub_proto_list_82' => 'sub_proto_list', [ 'sub_proto_list', 'proto' ], 0 ],
  [ 'proto_83' => 'proto', [ 'LOAD' ], 0 ],
  [ 'proto_84' => 'proto', [ 'INIT' ], 0 ],
  [ 'proto_85' => 'proto', [ 'MAIN' ], 0 ],
  [ 'proto_86' => 'proto', [ 'IMMEDIATE' ], 0 ],
  [ 'proto_87' => 'proto', [ 'POSTCOMP' ], 0 ],
  [ 'proto_88' => 'proto', [ 'ANON' ], 0 ],
  [ 'proto_89' => 'proto', [ 'NEED_LEX' ], 0 ],
  [ 'proto_90' => 'proto', [ 'multi' ], 0 ],
  [ 'proto_91' => 'proto', [ 'outer' ], 0 ],
  [ 'proto_92' => 'proto', [ 'vtable' ], 0 ],
  [ 'proto_93' => 'proto', [ 'method' ], 0 ],
  [ 'proto_94' => 'proto', [ 'ns_entry_name' ], 0 ],
  [ 'proto_95' => 'proto', [ 'instanceof' ], 0 ],
  [ 'proto_96' => 'proto', [ 'subid' ], 0 ],
  [ 'pcc_call_97' => 'pcc_call', [ 'PCC_CALL', 'var', 'COMMA', 'var', '\n' ], 0 ],
  [ 'pcc_call_98' => 'pcc_call', [ 'PCC_CALL', 'var', '\n' ], 0 ],
  [ 'pcc_call_99' => 'pcc_call', [ 'NCI_CALL', 'var', '\n' ], 0 ],
  [ 'pcc_call_100' => 'pcc_call', [ 'METH_CALL', 'target', '\n' ], 0 ],
  [ 'pcc_call_101' => 'pcc_call', [ 'METH_CALL', 'STRINGC', '\n' ], 0 ],
  [ 'pcc_call_102' => 'pcc_call', [ 'METH_CALL', 'target', 'COMMA', 'var', '\n' ], 0 ],
  [ 'pcc_call_103' => 'pcc_call', [ 'METH_CALL', 'STRINGC', 'COMMA', 'var', '\n' ], 0 ],
  [ 'pcc_args_104' => 'pcc_args', [  ], 0 ],
  [ 'pcc_args_105' => 'pcc_args', [ 'pcc_args', 'pcc_arg', '\n' ], 0 ],
  [ 'pcc_arg_106' => 'pcc_arg', [ 'ARG', 'arg' ], 0 ],
  [ 'pcc_results_107' => 'pcc_results', [  ], 0 ],
  [ 'pcc_results_108' => 'pcc_results', [ 'pcc_results', 'pcc_result', '\n' ], 0 ],
  [ 'pcc_result_109' => 'pcc_result', [ 'RESULT', 'target', 'paramtype_list' ], 0 ],
  [ 'pcc_result_110' => 'pcc_result', [ 'LOCAL', 'type', 'id_list_id' ], 0 ],
  [ 'paramtype_list_111' => 'paramtype_list', [  ], 0 ],
  [ 'paramtype_list_112' => 'paramtype_list', [ 'paramtype_list', 'paramtype' ], 0 ],
  [ 'paramtype_113' => 'paramtype', [ 'ADV_SLURPY' ], 0 ],
  [ 'paramtype_114' => 'paramtype', [ 'ADV_OPTIONAL' ], 0 ],
  [ 'paramtype_115' => 'paramtype', [ 'ADV_OPT_FLAG' ], 0 ],
  [ 'paramtype_116' => 'paramtype', [ 'ADV_NAMED' ], 0 ],
  [ 'paramtype_117' => 'paramtype', [ 'ADV_NAMED', '(', 'STRINGC', ')' ], 0 ],
  [ 'paramtype_118' => 'paramtype', [ 'ADV_NAMED', '(', 'USTRINGC', ')' ], 0 ],
  [ 'paramtype_119' => 'paramtype', [ 'UNIQUE_REG' ], 0 ],
  [ 'paramtype_120' => 'paramtype', [ 'ADV_CALL_SIG' ], 0 ],
  [ 'pcc_ret_121' => 'pcc_ret', [ 'PCC_BEGIN_RETURN', '\n', 'pcc_returns', 'PCC_END_RETURN' ], 0 ],
  [ 'pcc_ret_122' => 'pcc_ret', [ 'pcc_return_many' ], 0 ],
  [ 'pcc_yield_123' => 'pcc_yield', [ 'PCC_BEGIN_YIELD', '\n', 'pcc_yields', 'PCC_END_YIELD' ], 0 ],
  [ 'pcc_returns_124' => 'pcc_returns', [  ], 0 ],
  [ 'pcc_returns_125' => 'pcc_returns', [ 'pcc_returns', '\n' ], 0 ],
  [ 'pcc_returns_126' => 'pcc_returns', [ 'pcc_returns', 'pcc_return', '\n' ], 0 ],
  [ 'pcc_yields_127' => 'pcc_yields', [  ], 0 ],
  [ 'pcc_yields_128' => 'pcc_yields', [ 'pcc_yields', '\n' ], 0 ],
  [ 'pcc_yields_129' => 'pcc_yields', [ 'pcc_yields', 'pcc_set_yield', '\n' ], 0 ],
  [ 'pcc_return_130' => 'pcc_return', [ 'SET_RETURN', 'var', 'argtype_list' ], 0 ],
  [ 'pcc_set_yield_131' => 'pcc_set_yield', [ 'SET_YIELD', 'var', 'argtype_list' ], 0 ],
  [ 'pcc_return_many_132' => 'pcc_return_many', [ 'return_or_yield', '(', 'var_returns', ')' ], 0 ],
  [ 'return_or_yield_133' => 'return_or_yield', [ 'RETURN' ], 0 ],
  [ 'return_or_yield_134' => 'return_or_yield', [ 'YIELDT' ], 0 ],
  [ 'var_returns_135' => 'var_returns', [  ], 0 ],
  [ 'var_returns_136' => 'var_returns', [ 'arg' ], 0 ],
  [ 'var_returns_137' => 'var_returns', [ 'STRINGC', 'ADV_ARROW', 'var' ], 0 ],
  [ 'var_returns_138' => 'var_returns', [ 'var_returns', 'COMMA', 'arg' ], 0 ],
  [ 'var_returns_139' => 'var_returns', [ 'var_returns', 'COMMA', 'STRINGC', 'ADV_ARROW', 'var' ], 0 ],
  [ 'statements_140' => 'statements', [ 'statement' ], 0 ],
  [ 'statements_141' => 'statements', [ 'statements', 'statement' ], 0 ],
  [ 'helper_clear_state_142' => 'helper_clear_state', [  ], 0 ],
  [ 'statement_143' => 'statement', [ 'helper_clear_state', 'instruction' ], 0 ],
  [ 'statement_144' => 'statement', [ 'MACRO', '\n' ], 0 ],
  [ 'statement_145' => 'statement', [ 'FILECOMMENT' ], 0 ],
  [ 'statement_146' => 'statement', [ 'LINECOMMENT' ], 0 ],
  [ 'statement_147' => 'statement', [ 'location_directive' ], 0 ],
  [ 'statement_148' => 'statement', [ 'annotate_directive' ], 0 ],
  [ 'labels_149' => 'labels', [  ], 0 ],
  [ 'labels_150' => 'labels', [ '_labels' ], 0 ],
  [ '_labels_151' => '_labels', [ '_labels', 'label' ], 0 ],
  [ '_labels_152' => '_labels', [ 'label' ], 0 ],
  [ 'label_153' => 'label', [ 'LABEL' ], 0 ],
  [ 'instruction_154' => 'instruction', [ 'labels', 'labeled_inst', '\n' ], 0 ],
  [ 'instruction_155' => 'instruction', [ 'error', '\n' ], 0 ],
  [ 'id_list_156' => 'id_list', [ 'id_list_id' ], 0 ],
  [ 'id_list_157' => 'id_list', [ 'id_list', 'COMMA', 'id_list_id' ], 0 ],
  [ 'id_list_id_158' => 'id_list_id', [ 'IDENTIFIER', 'opt_unique_reg' ], 0 ],
  [ 'opt_unique_reg_159' => 'opt_unique_reg', [  ], 0 ],
  [ 'opt_unique_reg_160' => 'opt_unique_reg', [ 'UNIQUE_REG' ], 0 ],
  [ 'labeled_inst_161' => 'labeled_inst', [ 'assignment' ], 0 ],
  [ 'labeled_inst_162' => 'labeled_inst', [ 'conditional_statement' ], 0 ],
  [ 'labeled_inst_163' => 'labeled_inst', [ 'LOCAL', 'type', 'id_list' ], 0 ],
  [ 'labeled_inst_164' => 'labeled_inst', [ 'LEXICAL', 'STRINGC', 'COMMA', 'target' ], 0 ],
  [ 'labeled_inst_165' => 'labeled_inst', [ 'LEXICAL', 'USTRINGC', 'COMMA', 'target' ], 0 ],
  [ 'labeled_inst_166' => 'labeled_inst', [ 'CONST', 'type', 'IDENTIFIER', '=', 'const' ], 0 ],
  [ 'labeled_inst_167' => 'labeled_inst', [ 'pmc_const' ], 0 ],
  [ 'labeled_inst_168' => 'labeled_inst', [ 'GLOBAL_CONST', 'type', 'IDENTIFIER', '=', 'const' ], 0 ],
  [ 'labeled_inst_169' => 'labeled_inst', [ 'TAILCALL', 'sub_call' ], 0 ],
  [ 'labeled_inst_170' => 'labeled_inst', [ 'GOTO', 'label_op' ], 0 ],
  [ 'labeled_inst_171' => 'labeled_inst', [ 'PARROT_OP', 'vars' ], 0 ],
  [ 'labeled_inst_172' => 'labeled_inst', [ 'PNULL', 'var' ], 0 ],
  [ 'labeled_inst_173' => 'labeled_inst', [ 'sub_call' ], 0 ],
  [ 'labeled_inst_174' => 'labeled_inst', [ 'pcc_sub_call' ], 0 ],
  [ 'labeled_inst_175' => 'labeled_inst', [ 'pcc_ret' ], 0 ],
  [ 'labeled_inst_176' => 'labeled_inst', [ 'pcc_yield' ], 0 ],
  [ 'labeled_inst_177' => 'labeled_inst', [  ], 0 ],
  [ 'type_178' => 'type', [ 'INTV' ], 0 ],
  [ 'type_179' => 'type', [ 'FLOATV' ], 0 ],
  [ 'type_180' => 'type', [ 'STRINGV' ], 0 ],
  [ 'type_181' => 'type', [ 'PMCV' ], 0 ],
  [ 'classname_182' => 'classname', [ 'IDENTIFIER' ], 0 ],
  [ 'assignment_183' => 'assignment', [ 'target', '=', 'var' ], 0 ],
  [ 'assignment_184' => 'assignment', [ 'target', '=', 'un_op', 'var' ], 0 ],
  [ 'assignment_185' => 'assignment', [ 'target', '=', 'var', 'bin_op', 'var' ], 0 ],
  [ 'assignment_186' => 'assignment', [ 'target', '=', 'var', '[', 'keylist', ']' ], 0 ],
  [ 'assignment_187' => 'assignment', [ 'target', '[', 'keylist', ']', '=', 'var' ], 0 ],
  [ 'assignment_188' => 'assignment', [ 'target', '=', 'new', 'classname', '[', 'keylist', ']' ], 0 ],
  [ 'assignment_189' => 'assignment', [ 'target', '=', 'sub_call' ], 0 ],
  [ 'assignment_190' => 'assignment', [ '(', 'targetlist', ')', '=', 'the_sub', '(', 'arglist', ')' ], 0 ],
  [ 'assignment_191' => 'assignment', [ 'get_results' ], 0 ],
  [ 'assignment_192' => 'assignment', [ 'op_assign' ], 0 ],
  [ 'assignment_193' => 'assignment', [ 'func_assign' ], 0 ],
  [ 'assignment_194' => 'assignment', [ 'target', '=', 'PNULL' ], 0 ],
  [ 'un_op_195' => 'un_op', [ '!' ], 0 ],
  [ 'un_op_196' => 'un_op', [ '~' ], 0 ],
  [ 'un_op_197' => 'un_op', [ '-' ], 0 ],
  [ 'bin_op_198' => 'bin_op', [ '-' ], 0 ],
  [ 'bin_op_199' => 'bin_op', [ '+' ], 0 ],
  [ 'bin_op_200' => 'bin_op', [ '*' ], 0 ],
  [ 'bin_op_201' => 'bin_op', [ '/' ], 0 ],
  [ 'bin_op_202' => 'bin_op', [ '%' ], 0 ],
  [ 'bin_op_203' => 'bin_op', [ 'FDIV' ], 0 ],
  [ 'bin_op_204' => 'bin_op', [ 'POW' ], 0 ],
  [ 'bin_op_205' => 'bin_op', [ 'CONCAT' ], 0 ],
  [ 'bin_op_206' => 'bin_op', [ 'RELOP_EQ' ], 0 ],
  [ 'bin_op_207' => 'bin_op', [ 'RELOP_NE' ], 0 ],
  [ 'bin_op_208' => 'bin_op', [ 'RELOP_GT' ], 0 ],
  [ 'bin_op_209' => 'bin_op', [ 'RELOP_GTE' ], 0 ],
  [ 'bin_op_210' => 'bin_op', [ 'RELOP_LT' ], 0 ],
  [ 'bin_op_211' => 'bin_op', [ 'RELOP_LTE' ], 0 ],
  [ 'bin_op_212' => 'bin_op', [ 'SHIFT_LEFT' ], 0 ],
  [ 'bin_op_213' => 'bin_op', [ 'SHIFT_RIGHT' ], 0 ],
  [ 'bin_op_214' => 'bin_op', [ 'SHIFT_RIGHT_U' ], 0 ],
  [ 'bin_op_215' => 'bin_op', [ 'LOG_AND' ], 0 ],
  [ 'bin_op_216' => 'bin_op', [ 'LOG_OR' ], 0 ],
  [ 'bin_op_217' => 'bin_op', [ 'LOG_XOR' ], 0 ],
  [ 'bin_op_218' => 'bin_op', [ '&' ], 0 ],
  [ 'bin_op_219' => 'bin_op', [ '|' ], 0 ],
  [ 'bin_op_220' => 'bin_op', [ '~' ], 0 ],
  [ 'get_results_221' => 'get_results', [ 'GET_RESULTS', '(', 'targetlist', ')' ], 0 ],
  [ 'op_assign_222' => 'op_assign', [ 'target', 'assign_op', 'var' ], 0 ],
  [ 'assign_op_223' => 'assign_op', [ 'PLUS_ASSIGN' ], 0 ],
  [ 'assign_op_224' => 'assign_op', [ 'MINUS_ASSIGN' ], 0 ],
  [ 'assign_op_225' => 'assign_op', [ 'MUL_ASSIGN' ], 0 ],
  [ 'assign_op_226' => 'assign_op', [ 'DIV_ASSIGN' ], 0 ],
  [ 'assign_op_227' => 'assign_op', [ 'MOD_ASSIGN' ], 0 ],
  [ 'assign_op_228' => 'assign_op', [ 'FDIV_ASSIGN' ], 0 ],
  [ 'assign_op_229' => 'assign_op', [ 'CONCAT_ASSIGN' ], 0 ],
  [ 'assign_op_230' => 'assign_op', [ 'BAND_ASSIGN' ], 0 ],
  [ 'assign_op_231' => 'assign_op', [ 'BOR_ASSIGN' ], 0 ],
  [ 'assign_op_232' => 'assign_op', [ 'BXOR_ASSIGN' ], 0 ],
  [ 'assign_op_233' => 'assign_op', [ 'SHR_ASSIGN' ], 0 ],
  [ 'assign_op_234' => 'assign_op', [ 'SHL_ASSIGN' ], 0 ],
  [ 'assign_op_235' => 'assign_op', [ 'SHR_U_ASSIGN' ], 0 ],
  [ 'func_assign_236' => 'func_assign', [ 'target', '=', 'PARROT_OP', 'pasm_args' ], 0 ],
  [ 'the_sub_237' => 'the_sub', [ 'IDENTIFIER' ], 0 ],
  [ 'the_sub_238' => 'the_sub', [ 'STRINGC' ], 0 ],
  [ 'the_sub_239' => 'the_sub', [ 'USTRINGC' ], 0 ],
  [ 'the_sub_240' => 'the_sub', [ 'target' ], 0 ],
  [ 'the_sub_241' => 'the_sub', [ 'target', 'DOT', 'sub_label_op' ], 0 ],
  [ 'the_sub_242' => 'the_sub', [ 'target', 'DOT', 'USTRINGC' ], 0 ],
  [ 'the_sub_243' => 'the_sub', [ 'target', 'DOT', 'STRINGC' ], 0 ],
  [ 'the_sub_244' => 'the_sub', [ 'target', 'DOT', 'target' ], 0 ],
  [ 'sub_call_245' => 'sub_call', [ 'the_sub', '(', 'arglist', ')' ], 0 ],
  [ 'arglist_246' => 'arglist', [  ], 0 ],
  [ 'arglist_247' => 'arglist', [ 'arglist', 'COMMA', 'arg' ], 0 ],
  [ 'arglist_248' => 'arglist', [ 'arg' ], 0 ],
  [ 'arglist_249' => 'arglist', [ 'arglist', 'COMMA', 'STRINGC', 'ADV_ARROW', 'var' ], 0 ],
  [ 'arglist_250' => 'arglist', [ 'var', 'ADV_ARROW', 'var' ], 0 ],
  [ 'arglist_251' => 'arglist', [ 'STRINGC', 'ADV_ARROW', 'var' ], 0 ],
  [ 'arg_252' => 'arg', [ 'var', 'argtype_list' ], 0 ],
  [ 'argtype_list_253' => 'argtype_list', [  ], 0 ],
  [ 'argtype_list_254' => 'argtype_list', [ 'argtype_list', 'argtype' ], 0 ],
  [ 'argtype_255' => 'argtype', [ 'ADV_FLAT' ], 0 ],
  [ 'argtype_256' => 'argtype', [ 'ADV_NAMED' ], 0 ],
  [ 'argtype_257' => 'argtype', [ 'ADV_CALL_SIG' ], 0 ],
  [ 'argtype_258' => 'argtype', [ 'ADV_NAMED', '(', 'USTRINGC', ')' ], 0 ],
  [ 'argtype_259' => 'argtype', [ 'ADV_NAMED', '(', 'STRINGC', ')' ], 0 ],
  [ 'result_260' => 'result', [ 'target', 'paramtype_list' ], 0 ],
  [ 'targetlist_261' => 'targetlist', [ 'targetlist', 'COMMA', 'result' ], 0 ],
  [ 'targetlist_262' => 'targetlist', [ 'targetlist', 'COMMA', 'STRINGC', 'ADV_ARROW', 'target' ], 0 ],
  [ 'targetlist_263' => 'targetlist', [ 'result' ], 0 ],
  [ 'targetlist_264' => 'targetlist', [ 'STRINGC', 'ADV_ARROW', 'target' ], 0 ],
  [ 'targetlist_265' => 'targetlist', [  ], 0 ],
  [ 'conditional_statement_266' => 'conditional_statement', [ 'if_statement' ], 0 ],
  [ 'conditional_statement_267' => 'conditional_statement', [ 'unless_statement' ], 0 ],
  [ 'unless_statement_268' => 'unless_statement', [ 'UNLESS', 'var', 'relop', 'var', 'GOTO', 'label_op' ], 0 ],
  [ 'unless_statement_269' => 'unless_statement', [ 'UNLESS', 'PNULL', 'var', 'GOTO', 'label_op' ], 0 ],
  [ 'unless_statement_270' => 'unless_statement', [ 'UNLESS', 'var', 'comma_or_goto', 'label_op' ], 0 ],
  [ 'if_statement_271' => 'if_statement', [ 'IF', 'var', 'comma_or_goto', 'label_op' ], 0 ],
  [ 'if_statement_272' => 'if_statement', [ 'IF', 'var', 'relop', 'var', 'GOTO', 'label_op' ], 0 ],
  [ 'if_statement_273' => 'if_statement', [ 'IF', 'PNULL', 'var', 'GOTO', 'label_op' ], 0 ],
  [ 'comma_or_goto_274' => 'comma_or_goto', [ 'COMMA' ], 0 ],
  [ 'comma_or_goto_275' => 'comma_or_goto', [ 'GOTO' ], 0 ],
  [ 'relop_276' => 'relop', [ 'RELOP_EQ' ], 0 ],
  [ 'relop_277' => 'relop', [ 'RELOP_NE' ], 0 ],
  [ 'relop_278' => 'relop', [ 'RELOP_GT' ], 0 ],
  [ 'relop_279' => 'relop', [ 'RELOP_GTE' ], 0 ],
  [ 'relop_280' => 'relop', [ 'RELOP_LT' ], 0 ],
  [ 'relop_281' => 'relop', [ 'RELOP_LTE' ], 0 ],
  [ 'target_282' => 'target', [ 'VAR' ], 0 ],
  [ 'target_283' => 'target', [ 'reg' ], 0 ],
  [ 'vars_284' => 'vars', [  ], 0 ],
  [ 'vars_285' => 'vars', [ '_vars' ], 0 ],
  [ '_vars_286' => '_vars', [ '_vars', 'COMMA', '_var_or_i' ], 0 ],
  [ '_vars_287' => '_vars', [ '_var_or_i' ], 0 ],
  [ '_var_or_i_288' => '_var_or_i', [ 'var_or_i' ], 0 ],
  [ '_var_or_i_289' => '_var_or_i', [ 'target', '[', 'keylist', ']' ], 0 ],
  [ '_var_or_i_290' => '_var_or_i', [ '[', 'keylist_force', ']' ], 0 ],
  [ 'sub_label_op_c_291' => 'sub_label_op_c', [ 'sub_label_op' ], 0 ],
  [ 'sub_label_op_c_292' => 'sub_label_op_c', [ 'STRINGC' ], 0 ],
  [ 'sub_label_op_c_293' => 'sub_label_op_c', [ 'USTRINGC' ], 0 ],
  [ 'sub_label_op_294' => 'sub_label_op', [ 'IDENTIFIER' ], 0 ],
  [ 'sub_label_op_295' => 'sub_label_op', [ 'PARROT_OP' ], 0 ],
  [ 'label_op_296' => 'label_op', [ 'IDENTIFIER' ], 0 ],
  [ 'label_op_297' => 'label_op', [ 'PARROT_OP' ], 0 ],
  [ 'var_or_i_298' => 'var_or_i', [ 'label_op' ], 0 ],
  [ 'var_or_i_299' => 'var_or_i', [ 'var' ], 0 ],
  [ 'var_300' => 'var', [ 'target' ], 0 ],
  [ 'var_301' => 'var', [ 'const' ], 0 ],
  [ 'keylist_302' => 'keylist', [ '_keylist' ], 0 ],
  [ 'keylist_force_303' => 'keylist_force', [ '_keylist' ], 0 ],
  [ '_keylist_304' => '_keylist', [ 'key' ], 0 ],
  [ '_keylist_305' => '_keylist', [ '_keylist', ';', 'key' ], 0 ],
  [ 'key_306' => 'key', [ 'var' ], 0 ],
  [ 'reg_307' => 'reg', [ 'IREG' ], 0 ],
  [ 'reg_308' => 'reg', [ 'NREG' ], 0 ],
  [ 'reg_309' => 'reg', [ 'SREG' ], 0 ],
  [ 'reg_310' => 'reg', [ 'PREG' ], 0 ],
  [ 'reg_311' => 'reg', [ 'REG' ], 0 ],
  [ 'const_312' => 'const', [ 'INTC' ], 0 ],
  [ 'const_313' => 'const', [ 'FLOATC' ], 0 ],
  [ 'const_314' => 'const', [ 'STRINGC' ], 0 ],
  [ 'const_315' => 'const', [ 'USTRINGC' ], 0 ],
],
    yyTERMS  =>
{ '' => { ISSEMANTIC => 0 },
	'!' => { ISSEMANTIC => 0 },
	'%' => { ISSEMANTIC => 0 },
	'&' => { ISSEMANTIC => 0 },
	'(' => { ISSEMANTIC => 0 },
	')' => { ISSEMANTIC => 0 },
	'*' => { ISSEMANTIC => 0 },
	'+' => { ISSEMANTIC => 0 },
	'-' => { ISSEMANTIC => 0 },
	'/' => { ISSEMANTIC => 0 },
	';' => { ISSEMANTIC => 0 },
	'=' => { ISSEMANTIC => 0 },
	'[' => { ISSEMANTIC => 0 },
	'\n' => { ISSEMANTIC => 0 },
	']' => { ISSEMANTIC => 0 },
	'new' => { ISSEMANTIC => 0 },
	'|' => { ISSEMANTIC => 0 },
	'~' => { ISSEMANTIC => 0 },
	ADV_ARROW => { ISSEMANTIC => 1 },
	ADV_CALL_SIG => { ISSEMANTIC => 1 },
	ADV_FLAT => { ISSEMANTIC => 1 },
	ADV_NAMED => { ISSEMANTIC => 1 },
	ADV_OPTIONAL => { ISSEMANTIC => 1 },
	ADV_OPT_FLAG => { ISSEMANTIC => 1 },
	ADV_SLURPY => { ISSEMANTIC => 1 },
	ANNOTATE => { ISSEMANTIC => 1 },
	ANON => { ISSEMANTIC => 1 },
	ARG => { ISSEMANTIC => 1 },
	BAND_ASSIGN => { ISSEMANTIC => 1 },
	BOR_ASSIGN => { ISSEMANTIC => 1 },
	BXOR_ASSIGN => { ISSEMANTIC => 1 },
	COMMA => { ISSEMANTIC => 1 },
	CONCAT => { ISSEMANTIC => 1 },
	CONCAT_ASSIGN => { ISSEMANTIC => 1 },
	CONST => { ISSEMANTIC => 1 },
	DIV_ASSIGN => { ISSEMANTIC => 1 },
	DOT => { ISSEMANTIC => 1 },
	EMIT => { ISSEMANTIC => 1 },
	EOM => { ISSEMANTIC => 1 },
	ESUB => { ISSEMANTIC => 1 },
	FDIV => { ISSEMANTIC => 1 },
	FDIV_ASSIGN => { ISSEMANTIC => 1 },
	FILECOMMENT => { ISSEMANTIC => 1 },
	FLOATC => { ISSEMANTIC => 1 },
	FLOATV => { ISSEMANTIC => 1 },
	GET_RESULTS => { ISSEMANTIC => 1 },
	GLOBAL_CONST => { ISSEMANTIC => 1 },
	GOTO => { ISSEMANTIC => 1 },
	HLL => { ISSEMANTIC => 1 },
	IDENTIFIER => { ISSEMANTIC => 1 },
	IF => { ISSEMANTIC => 1 },
	IMMEDIATE => { ISSEMANTIC => 1 },
	INIT => { ISSEMANTIC => 1 },
	INTC => { ISSEMANTIC => 1 },
	INTV => { ISSEMANTIC => 1 },
	INVOCANT => { ISSEMANTIC => 1 },
	IREG => { ISSEMANTIC => 1 },
	LABEL => { ISSEMANTIC => 1 },
	LEXICAL => { ISSEMANTIC => 1 },
	LINECOMMENT => { ISSEMANTIC => 1 },
	LOAD => { ISSEMANTIC => 1 },
	LOADLIB => { ISSEMANTIC => 1 },
	LOCAL => { ISSEMANTIC => 1 },
	LOG_AND => { ISSEMANTIC => 1 },
	LOG_OR => { ISSEMANTIC => 1 },
	LOG_XOR => { ISSEMANTIC => 1 },
	LOW_PREC => { ISSEMANTIC => 1 },
	MACRO => { ISSEMANTIC => 1 },
	MAIN => { ISSEMANTIC => 1 },
	METHOD => { ISSEMANTIC => 1 },
	METH_CALL => { ISSEMANTIC => 1 },
	MINUS_ASSIGN => { ISSEMANTIC => 1 },
	MOD_ASSIGN => { ISSEMANTIC => 1 },
	MULTI => { ISSEMANTIC => 1 },
	MUL_ASSIGN => { ISSEMANTIC => 1 },
	NAMESPACE => { ISSEMANTIC => 1 },
	NCI_CALL => { ISSEMANTIC => 1 },
	NEED_LEX => { ISSEMANTIC => 1 },
	NREG => { ISSEMANTIC => 1 },
	NS_ENTRY => { ISSEMANTIC => 1 },
	OUTER => { ISSEMANTIC => 1 },
	PARAM => { ISSEMANTIC => 1 },
	PARROT_OP => { ISSEMANTIC => 1 },
	PCC_BEGIN => { ISSEMANTIC => 1 },
	PCC_BEGIN_RETURN => { ISSEMANTIC => 1 },
	PCC_BEGIN_YIELD => { ISSEMANTIC => 1 },
	PCC_CALL => { ISSEMANTIC => 1 },
	PCC_END => { ISSEMANTIC => 1 },
	PCC_END_RETURN => { ISSEMANTIC => 1 },
	PCC_END_YIELD => { ISSEMANTIC => 1 },
	PCC_SUB => { ISSEMANTIC => 1 },
	PLUS_ASSIGN => { ISSEMANTIC => 1 },
	PMCV => { ISSEMANTIC => 1 },
	PNULL => { ISSEMANTIC => 1 },
	POSTCOMP => { ISSEMANTIC => 1 },
	POW => { ISSEMANTIC => 1 },
	PREG => { ISSEMANTIC => 1 },
	REG => { ISSEMANTIC => 1 },
	RELOP_EQ => { ISSEMANTIC => 1 },
	RELOP_GT => { ISSEMANTIC => 1 },
	RELOP_GTE => { ISSEMANTIC => 1 },
	RELOP_LT => { ISSEMANTIC => 1 },
	RELOP_LTE => { ISSEMANTIC => 1 },
	RELOP_NE => { ISSEMANTIC => 1 },
	RESULT => { ISSEMANTIC => 1 },
	RETURN => { ISSEMANTIC => 1 },
	SET_RETURN => { ISSEMANTIC => 1 },
	SET_YIELD => { ISSEMANTIC => 1 },
	SHIFT_LEFT => { ISSEMANTIC => 1 },
	SHIFT_RIGHT => { ISSEMANTIC => 1 },
	SHIFT_RIGHT_U => { ISSEMANTIC => 1 },
	SHL_ASSIGN => { ISSEMANTIC => 1 },
	SHR_ASSIGN => { ISSEMANTIC => 1 },
	SHR_U_ASSIGN => { ISSEMANTIC => 1 },
	SREG => { ISSEMANTIC => 1 },
	STRINGC => { ISSEMANTIC => 1 },
	STRINGV => { ISSEMANTIC => 1 },
	SUB => { ISSEMANTIC => 1 },
	SUBID => { ISSEMANTIC => 1 },
	SUB_INSTANCE_OF => { ISSEMANTIC => 1 },
	TAILCALL => { ISSEMANTIC => 1 },
	TK_FILE => { ISSEMANTIC => 1 },
	TK_LINE => { ISSEMANTIC => 1 },
	UNIQUE_REG => { ISSEMANTIC => 1 },
	UNLESS => { ISSEMANTIC => 1 },
	USTRINGC => { ISSEMANTIC => 1 },
	VAR => { ISSEMANTIC => 1 },
	VTABLE_METHOD => { ISSEMANTIC => 1 },
	YIELDT => { ISSEMANTIC => 1 },
	error => { ISSEMANTIC => 1 },
	error => { ISSEMANTIC => 0 },
},
    yyFILENAME  => 'PIR.eyp',
    yystates =>
[
	{#State 0
		ACTIONS => {
			'SUB' => 11,
			'NAMESPACE' => 1,
			"\n" => 12,
			'TK_LINE' => 3,
			'TK_FILE' => 2,
			'CONST' => 14,
			'EMIT' => 15,
			'HLL' => 10,
			'LOADLIB' => 18,
			'MACRO' => 17
		},
		GOTOS => {
			'compilation_unit' => 13,
			'location_directive' => 4,
			'program' => 6,
			'emit' => 5,
			'hll_def' => 7,
			'constdef' => 8,
			'pragma' => 9,
			'sub' => 16,
			'compilation_units' => 19,
			'class_namespace' => 20
		}
	},
	{#State 1
		ACTIONS => {
			"[" => 22
		},
		GOTOS => {
			'maybe_ns' => 21
		}
	},
	{#State 2
		ACTIONS => {
			'STRINGC' => 23
		}
	},
	{#State 3
		ACTIONS => {
			'INTC' => 24
		}
	},
	{#State 4
		DEFAULT => -10
	},
	{#State 5
		DEFAULT => -7
	},
	{#State 6
		ACTIONS => {
			'' => 25
		}
	},
	{#State 7
		ACTIONS => {
			"\n" => 26
		}
	},
	{#State 8
		DEFAULT => -5
	},
	{#State 9
		DEFAULT => -9
	},
	{#State 10
		ACTIONS => {
			'STRINGC' => 27
		}
	},
	{#State 11
		ACTIONS => {
			'IDENTIFIER' => 30,
			'STRINGC' => 28,
			'USTRINGC' => 29,
			'PARROT_OP' => 33
		},
		GOTOS => {
			'sub_label_op' => 31,
			'sub_label_op_c' => 32
		}
	},
	{#State 12
		DEFAULT => -11
	},
	{#State 13
		DEFAULT => -2
	},
	{#State 14
		ACTIONS => {
			'INTV' => 36,
			'FLOATV' => 35,
			'STRINGV' => 34,
			'PMCV' => 38
		},
		GOTOS => {
			'type' => 37
		}
	},
	{#State 15
		ACTIONS => {
			'FILECOMMENT' => 40,
			'NAMESPACE' => 1,
			'LABEL' => 41,
			'CONST' => 48,
			'LINECOMMENT' => 44,
			'HLL' => 10,
			'LOADLIB' => 18,
			'MACRO' => 49,
			'EOM' => -39
		},
		DEFAULT => -149,
		GOTOS => {
			'pmc_const' => 39,
			'pasmcode' => 47,
			'opt_pasmcode' => 43,
			'_labels' => 42,
			'hll_def' => 7,
			'pragma' => 45,
			'label' => 50,
			'labels' => 46,
			'pasmline' => 51,
			'class_namespace' => 52
		}
	},
	{#State 16
		DEFAULT => -6
	},
	{#State 17
		ACTIONS => {
			"\n" => 53
		}
	},
	{#State 18
		ACTIONS => {
			'STRINGC' => 54
		}
	},
	{#State 19
		ACTIONS => {
			'SUB' => 11,
			'NAMESPACE' => 1,
			"\n" => 12,
			'TK_LINE' => 3,
			'TK_FILE' => 2,
			'CONST' => 14,
			'EMIT' => 15,
			'HLL' => 10,
			'MACRO' => 17,
			'LOADLIB' => 18
		},
		DEFAULT => -1,
		GOTOS => {
			'compilation_unit' => 55,
			'location_directive' => 4,
			'emit' => 5,
			'hll_def' => 7,
			'pragma' => 9,
			'constdef' => 8,
			'sub' => 16,
			'class_namespace' => 20
		}
	},
	{#State 20
		DEFAULT => -4
	},
	{#State 21
		ACTIONS => {
			"\n" => 56
		}
	},
	{#State 22
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			"]" => 64,
			'REG' => 65
		},
		GOTOS => {
			'keylist' => 70,
			'_keylist' => 66,
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 63,
			'key' => 58
		}
	},
	{#State 23
		ACTIONS => {
			"\n" => 75
		}
	},
	{#State 24
		ACTIONS => {
			'COMMA' => 76
		}
	},
	{#State 25
		DEFAULT => 0
	},
	{#State 26
		DEFAULT => -12
	},
	{#State 27
		DEFAULT => -17
	},
	{#State 28
		DEFAULT => -292
	},
	{#State 29
		DEFAULT => -293
	},
	{#State 30
		DEFAULT => -294
	},
	{#State 31
		DEFAULT => -291
	},
	{#State 32
		ACTIONS => {
			'SUB_INSTANCE_OF' => 80,
			'NS_ENTRY' => 81,
			'IMMEDIATE' => 82,
			'MAIN' => 84,
			'INIT' => 85,
			'NEED_LEX' => 87,
			'VTABLE_METHOD' => 90,
			'POSTCOMP' => 93,
			'SUBID' => 94,
			'OUTER' => 95,
			'MULTI' => 96,
			'ANON' => 97,
			'LOAD' => 98,
			'METHOD' => 100
		},
		DEFAULT => -79,
		GOTOS => {
			'outer' => 78,
			'instanceof' => 77,
			'proto' => 91,
			'ns_entry_name' => 79,
			'sub_proto' => 92,
			'subid' => 83,
			'multi' => 99,
			'method' => 86,
			'sub_proto_list' => 88,
			'vtable' => 89
		}
	},
	{#State 33
		DEFAULT => -295
	},
	{#State 34
		DEFAULT => -180
	},
	{#State 35
		DEFAULT => -179
	},
	{#State 36
		DEFAULT => -178
	},
	{#State 37
		ACTIONS => {
			'IDENTIFIER' => 101
		}
	},
	{#State 38
		DEFAULT => -181
	},
	{#State 39
		DEFAULT => -30
	},
	{#State 40
		DEFAULT => -27
	},
	{#State 41
		DEFAULT => -153
	},
	{#State 42
		ACTIONS => {
			'LABEL' => 41
		},
		DEFAULT => -150,
		GOTOS => {
			'label' => 102
		}
	},
	{#State 43
		ACTIONS => {
			'EOM' => 103
		}
	},
	{#State 44
		DEFAULT => -28
	},
	{#State 45
		DEFAULT => -31
	},
	{#State 46
		ACTIONS => {
			'PNULL' => 104,
			'PCC_SUB' => 107,
			'PARROT_OP' => 108,
			'LEXICAL' => 106
		},
		DEFAULT => -36,
		GOTOS => {
			'pasm_inst' => 105
		}
	},
	{#State 47
		ACTIONS => {
			'FILECOMMENT' => 40,
			'NAMESPACE' => 1,
			'LABEL' => 41,
			'CONST' => 48,
			'LINECOMMENT' => 44,
			'HLL' => 10,
			'LOADLIB' => 18,
			'MACRO' => 49,
			'EOM' => -40
		},
		DEFAULT => -149,
		GOTOS => {
			'hll_def' => 7,
			'pragma' => 45,
			'pmc_const' => 39,
			'_labels' => 42,
			'label' => 50,
			'pasmline' => 109,
			'labels' => 46,
			'class_namespace' => 52
		}
	},
	{#State 48
		ACTIONS => {
			'STRINGC' => 110,
			'INTC' => 111
		}
	},
	{#State 49
		ACTIONS => {
			"\n" => 112
		}
	},
	{#State 50
		DEFAULT => -152
	},
	{#State 51
		DEFAULT => -23
	},
	{#State 52
		DEFAULT => -29
	},
	{#State 53
		DEFAULT => -8
	},
	{#State 54
		ACTIONS => {
			"\n" => 113
		}
	},
	{#State 55
		DEFAULT => -3
	},
	{#State 56
		DEFAULT => -41
	},
	{#State 57
		DEFAULT => -308
	},
	{#State 58
		DEFAULT => -304
	},
	{#State 59
		DEFAULT => -314
	},
	{#State 60
		DEFAULT => -300
	},
	{#State 61
		DEFAULT => -312
	},
	{#State 62
		DEFAULT => -315
	},
	{#State 63
		DEFAULT => -306
	},
	{#State 64
		DEFAULT => -43
	},
	{#State 65
		DEFAULT => -311
	},
	{#State 66
		ACTIONS => {
			";" => 114
		},
		DEFAULT => -302
	},
	{#State 67
		DEFAULT => -310
	},
	{#State 68
		DEFAULT => -307
	},
	{#State 69
		DEFAULT => -313
	},
	{#State 70
		ACTIONS => {
			"]" => 115
		}
	},
	{#State 71
		DEFAULT => -301
	},
	{#State 72
		DEFAULT => -283
	},
	{#State 73
		DEFAULT => -282
	},
	{#State 74
		DEFAULT => -309
	},
	{#State 75
		DEFAULT => -15
	},
	{#State 76
		ACTIONS => {
			'STRINGC' => 116
		}
	},
	{#State 77
		DEFAULT => -95
	},
	{#State 78
		DEFAULT => -91
	},
	{#State 79
		DEFAULT => -94
	},
	{#State 80
		ACTIONS => {
			"(" => 117
		}
	},
	{#State 81
		ACTIONS => {
			"(" => 118
		},
		DEFAULT => -57
	},
	{#State 82
		DEFAULT => -86
	},
	{#State 83
		DEFAULT => -96
	},
	{#State 84
		DEFAULT => -85
	},
	{#State 85
		DEFAULT => -84
	},
	{#State 86
		DEFAULT => -93
	},
	{#State 87
		DEFAULT => -89
	},
	{#State 88
		ACTIONS => {
			'SUB_INSTANCE_OF' => 80,
			'NS_ENTRY' => 81,
			'IMMEDIATE' => 82,
			'MAIN' => 84,
			'INIT' => 85,
			'NEED_LEX' => 87,
			'VTABLE_METHOD' => 90,
			'POSTCOMP' => 93,
			'SUBID' => 94,
			'OUTER' => 95,
			'MULTI' => 96,
			'ANON' => 97,
			'LOAD' => 98,
			'METHOD' => 100
		},
		DEFAULT => -80,
		GOTOS => {
			'outer' => 78,
			'instanceof' => 77,
			'proto' => 119,
			'ns_entry_name' => 79,
			'subid' => 83,
			'method' => 86,
			'multi' => 99,
			'vtable' => 89
		}
	},
	{#State 89
		DEFAULT => -92
	},
	{#State 90
		ACTIONS => {
			"(" => 120
		},
		DEFAULT => -53
	},
	{#State 91
		DEFAULT => -81
	},
	{#State 92
		ACTIONS => {
			"\n" => 121
		}
	},
	{#State 93
		DEFAULT => -87
	},
	{#State 94
		ACTIONS => {
			"(" => 122
		},
		DEFAULT => -60
	},
	{#State 95
		ACTIONS => {
			"(" => 123
		}
	},
	{#State 96
		ACTIONS => {
			"(" => 124
		}
	},
	{#State 97
		DEFAULT => -88
	},
	{#State 98
		DEFAULT => -83
	},
	{#State 99
		DEFAULT => -90
	},
	{#State 100
		ACTIONS => {
			"(" => 125
		},
		DEFAULT => -55
	},
	{#State 101
		ACTIONS => {
			"=" => 126
		}
	},
	{#State 102
		DEFAULT => -151
	},
	{#State 103
		DEFAULT => -38
	},
	{#State 104
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'INTC' => 61,
			'VAR' => 73,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 127
		}
	},
	{#State 105
		ACTIONS => {
			"\n" => 128
		}
	},
	{#State 106
		ACTIONS => {
			'STRINGC' => 129
		}
	},
	{#State 107
		ACTIONS => {
			'SUB_INSTANCE_OF' => 80,
			'NS_ENTRY' => 81,
			'IMMEDIATE' => 82,
			'MAIN' => 84,
			'INIT' => 85,
			'NEED_LEX' => 87,
			'VTABLE_METHOD' => 90,
			'POSTCOMP' => 93,
			'SUBID' => 94,
			'OUTER' => 95,
			'MULTI' => 96,
			'ANON' => 97,
			'LOAD' => 98,
			'METHOD' => 100
		},
		DEFAULT => -79,
		GOTOS => {
			'outer' => 78,
			'instanceof' => 77,
			'proto' => 91,
			'ns_entry_name' => 79,
			'sub_proto' => 130,
			'subid' => 83,
			'multi' => 99,
			'method' => 86,
			'sub_proto_list' => 88,
			'vtable' => 89
		}
	},
	{#State 108
		ACTIONS => {
			'IDENTIFIER' => 137,
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			"[" => 136,
			'PARROT_OP' => 141,
			'SREG' => 74,
			'REG' => 65
		},
		DEFAULT => -284,
		GOTOS => {
			'var_or_i' => 131,
			'_var_or_i' => 138,
			'_vars' => 132,
			'label_op' => 133,
			'vars' => 139,
			'pasm_args' => 140,
			'target' => 134,
			'const' => 71,
			'reg' => 72,
			'var' => 135
		}
	},
	{#State 109
		DEFAULT => -24
	},
	{#State 110
		ACTIONS => {
			'IDENTIFIER' => 137,
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'PARROT_OP' => 141,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'var_or_i' => 142,
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 135,
			'label_op' => 133
		}
	},
	{#State 111
		ACTIONS => {
			'IDENTIFIER' => 137,
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'PARROT_OP' => 141,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'var_or_i' => 143,
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 135,
			'label_op' => 133
		}
	},
	{#State 112
		DEFAULT => -26
	},
	{#State 113
		DEFAULT => -13
	},
	{#State 114
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'INTC' => 61,
			'VAR' => 73,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 63,
			'key' => 144
		}
	},
	{#State 115
		DEFAULT => -42
	},
	{#State 116
		ACTIONS => {
			"\n" => 145
		}
	},
	{#State 117
		ACTIONS => {
			'STRINGC' => 146
		}
	},
	{#State 118
		ACTIONS => {
			'STRINGC' => 148,
			'USTRINGC' => 149
		},
		GOTOS => {
			'any_string' => 147
		}
	},
	{#State 119
		DEFAULT => -82
	},
	{#State 120
		ACTIONS => {
			'STRINGC' => 150
		}
	},
	{#State 121
		ACTIONS => {
			"\n" => 152
		},
		DEFAULT => -45,
		GOTOS => {
			'sub_params' => 151
		}
	},
	{#State 122
		ACTIONS => {
			'STRINGC' => 148,
			'USTRINGC' => 149
		},
		GOTOS => {
			'any_string' => 153
		}
	},
	{#State 123
		ACTIONS => {
			'IDENTIFIER' => 155,
			'STRINGC' => 154
		}
	},
	{#State 124
		ACTIONS => {
			'INTV' => 162,
			'IDENTIFIER' => 161,
			'STRINGC' => 157,
			'STRINGV' => 158,
			'FLOATV' => 159,
			"[" => 160,
			'PMCV' => 164
		},
		DEFAULT => -62,
		GOTOS => {
			'multi_type' => 163,
			'multi_types' => 156
		}
	},
	{#State 125
		ACTIONS => {
			'STRINGC' => 148,
			'USTRINGC' => 149
		},
		GOTOS => {
			'any_string' => 165
		}
	},
	{#State 126
		ACTIONS => {
			'FLOATC' => 69,
			'STRINGC' => 59,
			'INTC' => 61,
			'USTRINGC' => 62
		},
		GOTOS => {
			'const' => 166
		}
	},
	{#State 127
		DEFAULT => -34
	},
	{#State 128
		DEFAULT => -25
	},
	{#State 129
		ACTIONS => {
			'COMMA' => 167
		}
	},
	{#State 130
		ACTIONS => {
			'LABEL' => 168
		}
	},
	{#State 131
		DEFAULT => -288
	},
	{#State 132
		ACTIONS => {
			'COMMA' => 169
		},
		DEFAULT => -285
	},
	{#State 133
		DEFAULT => -298
	},
	{#State 134
		ACTIONS => {
			"[" => 170
		},
		DEFAULT => -300
	},
	{#State 135
		DEFAULT => -299
	},
	{#State 136
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'INTC' => 61,
			'VAR' => 73,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'_keylist' => 172,
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 63,
			'keylist_force' => 171,
			'key' => 58
		}
	},
	{#State 137
		DEFAULT => -296
	},
	{#State 138
		DEFAULT => -287
	},
	{#State 139
		DEFAULT => -37
	},
	{#State 140
		DEFAULT => -32
	},
	{#State 141
		DEFAULT => -297
	},
	{#State 142
		ACTIONS => {
			"=" => 173
		}
	},
	{#State 143
		ACTIONS => {
			"=" => 174
		}
	},
	{#State 144
		DEFAULT => -305
	},
	{#State 145
		DEFAULT => -14
	},
	{#State 146
		ACTIONS => {
			")" => 175
		}
	},
	{#State 147
		ACTIONS => {
			")" => 176
		}
	},
	{#State 148
		DEFAULT => -21
	},
	{#State 149
		DEFAULT => -22
	},
	{#State 150
		ACTIONS => {
			")" => 177
		}
	},
	{#State 151
		ACTIONS => {
			'FILECOMMENT' => 179,
			'TK_FILE' => 2,
			'ANNOTATE' => 181,
			'LINECOMMENT' => 182,
			'MACRO' => 187,
			'PARAM' => 188,
			'TK_LINE' => 3,
			'ESUB' => -72
		},
		DEFAULT => -142,
		GOTOS => {
			'sub_body' => 186,
			'helper_clear_state' => 185,
			'statements' => 178,
			'statement' => 183,
			'annotate_directive' => 184,
			'sub_param' => 189,
			'location_directive' => 180
		}
	},
	{#State 152
		DEFAULT => -46
	},
	{#State 153
		ACTIONS => {
			")" => 190
		}
	},
	{#State 154
		ACTIONS => {
			")" => 191
		}
	},
	{#State 155
		ACTIONS => {
			")" => 192
		}
	},
	{#State 156
		ACTIONS => {
			'COMMA' => 194,
			")" => 193
		}
	},
	{#State 157
		DEFAULT => -70
	},
	{#State 158
		DEFAULT => -68
	},
	{#State 159
		DEFAULT => -66
	},
	{#State 160
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'INTC' => 61,
			'VAR' => 73,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'keylist' => 195,
			'_keylist' => 66,
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 63,
			'key' => 58
		}
	},
	{#State 161
		DEFAULT => -69
	},
	{#State 162
		DEFAULT => -65
	},
	{#State 163
		DEFAULT => -64
	},
	{#State 164
		DEFAULT => -67
	},
	{#State 165
		ACTIONS => {
			")" => 196
		}
	},
	{#State 166
		DEFAULT => -18
	},
	{#State 167
		ACTIONS => {
			'REG' => 197
		}
	},
	{#State 168
		DEFAULT => -33
	},
	{#State 169
		ACTIONS => {
			'IDENTIFIER' => 137,
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			"[" => 136,
			'PARROT_OP' => 141,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'var_or_i' => 131,
			'_var_or_i' => 198,
			'target' => 134,
			'reg' => 72,
			'const' => 71,
			'var' => 135,
			'label_op' => 133
		}
	},
	{#State 170
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'INTC' => 61,
			'VAR' => 73,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'keylist' => 199,
			'_keylist' => 66,
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 63,
			'key' => 58
		}
	},
	{#State 171
		ACTIONS => {
			"]" => 200
		}
	},
	{#State 172
		ACTIONS => {
			";" => 114
		},
		DEFAULT => -303
	},
	{#State 173
		ACTIONS => {
			'STRINGC' => 148,
			'USTRINGC' => 149
		},
		GOTOS => {
			'any_string' => 201
		}
	},
	{#State 174
		ACTIONS => {
			'STRINGC' => 148,
			'USTRINGC' => 149
		},
		GOTOS => {
			'any_string' => 202
		}
	},
	{#State 175
		DEFAULT => -59
	},
	{#State 176
		DEFAULT => -58
	},
	{#State 177
		DEFAULT => -54
	},
	{#State 178
		ACTIONS => {
			'FILECOMMENT' => 179,
			'TK_FILE' => 2,
			'ANNOTATE' => 181,
			'LINECOMMENT' => 182,
			'MACRO' => 187,
			'TK_LINE' => 3,
			'ESUB' => -73
		},
		DEFAULT => -142,
		GOTOS => {
			'helper_clear_state' => 185,
			'statement' => 203,
			'annotate_directive' => 184,
			'location_directive' => 180
		}
	},
	{#State 179
		DEFAULT => -145
	},
	{#State 180
		DEFAULT => -147
	},
	{#State 181
		ACTIONS => {
			'STRINGC' => 204
		}
	},
	{#State 182
		DEFAULT => -146
	},
	{#State 183
		DEFAULT => -140
	},
	{#State 184
		DEFAULT => -148
	},
	{#State 185
		ACTIONS => {
			'PNULL' => -149,
			'NREG' => -149,
			'LABEL' => 41,
			'YIELDT' => -149,
			'GOTO' => -149,
			'UNLESS' => -149,
			'GLOBAL_CONST' => -149,
			'STRINGC' => -149,
			'RETURN' => -149,
			'IF' => -149,
			'USTRINGC' => -149,
			'error' => 206,
			'LEXICAL' => -149,
			'LOCAL' => -149,
			'REG' => -149,
			'IDENTIFIER' => -149,
			'PREG' => -149,
			'PCC_BEGIN_RETURN' => -149,
			"\n" => -149,
			'CONST' => -149,
			'PCC_BEGIN' => -149,
			'GET_RESULTS' => -149,
			'IREG' => -149,
			"(" => -149,
			'VAR' => -149,
			'PCC_BEGIN_YIELD' => -149,
			'TAILCALL' => -149,
			'SREG' => -149,
			'PARROT_OP' => -149
		},
		GOTOS => {
			'_labels' => 42,
			'label' => 50,
			'instruction' => 205,
			'labels' => 207
		}
	},
	{#State 186
		ACTIONS => {
			'ESUB' => 208
		}
	},
	{#State 187
		ACTIONS => {
			"\n" => 209
		}
	},
	{#State 188
		ACTIONS => {
			'INTV' => 36,
			'FLOATV' => 35,
			'STRINGV' => 34,
			'PMCV' => 38
		},
		GOTOS => {
			'sub_param_type_def' => 210,
			'type' => 211
		}
	},
	{#State 189
		ACTIONS => {
			"\n" => 212
		}
	},
	{#State 190
		DEFAULT => -61
	},
	{#State 191
		DEFAULT => -51
	},
	{#State 192
		DEFAULT => -52
	},
	{#State 193
		DEFAULT => -50
	},
	{#State 194
		ACTIONS => {
			'INTV' => 162,
			'IDENTIFIER' => 161,
			'STRINGC' => 157,
			'FLOATV' => 159,
			'STRINGV' => 158,
			"[" => 160,
			'PMCV' => 164
		},
		GOTOS => {
			'multi_type' => 213
		}
	},
	{#State 195
		ACTIONS => {
			"]" => 214
		}
	},
	{#State 196
		DEFAULT => -56
	},
	{#State 197
		DEFAULT => -35
	},
	{#State 198
		DEFAULT => -286
	},
	{#State 199
		ACTIONS => {
			"]" => 215
		}
	},
	{#State 200
		DEFAULT => -290
	},
	{#State 201
		DEFAULT => -20
	},
	{#State 202
		DEFAULT => -19
	},
	{#State 203
		DEFAULT => -141
	},
	{#State 204
		ACTIONS => {
			'COMMA' => 216
		}
	},
	{#State 205
		DEFAULT => -143
	},
	{#State 206
		ACTIONS => {
			"\n" => 217
		}
	},
	{#State 207
		ACTIONS => {
			'PNULL' => 236,
			'NREG' => 57,
			'YIELDT' => 220,
			'GOTO' => 219,
			'GLOBAL_CONST' => 238,
			'UNLESS' => 221,
			'STRINGC' => 240,
			'RETURN' => 242,
			'IF' => 224,
			'USTRINGC' => 244,
			'LEXICAL' => 245,
			'LOCAL' => 246,
			'REG' => 65,
			'IDENTIFIER' => 225,
			'PREG' => 67,
			'PCC_BEGIN_RETURN' => 227,
			'CONST' => 250,
			'PCC_BEGIN' => 229,
			'IREG' => 68,
			'GET_RESULTS' => 230,
			"(" => 231,
			'PCC_BEGIN_YIELD' => 252,
			'VAR' => 73,
			'TAILCALL' => 254,
			'SREG' => 74,
			'PARROT_OP' => 233
		},
		DEFAULT => -177,
		GOTOS => {
			'conditional_statement' => 234,
			'pmc_const' => 235,
			'unless_statement' => 237,
			'op_assign' => 218,
			'labeled_inst' => 239,
			'pcc_yield' => 222,
			'target' => 223,
			'the_sub' => 241,
			'pcc_ret' => 243,
			'func_assign' => 247,
			'assignment' => 226,
			'if_statement' => 248,
			'get_results' => 228,
			'pcc_sub_call' => 249,
			'pcc_return_many' => 251,
			'reg' => 72,
			'return_or_yield' => 232,
			'sub_call' => 253
		}
	},
	{#State 208
		DEFAULT => -44
	},
	{#State 209
		DEFAULT => -144
	},
	{#State 210
		DEFAULT => -48
	},
	{#State 211
		ACTIONS => {
			'IDENTIFIER' => 255
		}
	},
	{#State 212
		DEFAULT => -47
	},
	{#State 213
		DEFAULT => -63
	},
	{#State 214
		DEFAULT => -71
	},
	{#State 215
		DEFAULT => -289
	},
	{#State 216
		ACTIONS => {
			'FLOATC' => 69,
			'STRINGC' => 59,
			'INTC' => 61,
			'USTRINGC' => 62
		},
		GOTOS => {
			'const' => 256
		}
	},
	{#State 217
		DEFAULT => -155
	},
	{#State 218
		DEFAULT => -192
	},
	{#State 219
		ACTIONS => {
			'IDENTIFIER' => 137,
			'PARROT_OP' => 141
		},
		GOTOS => {
			'label_op' => 257
		}
	},
	{#State 220
		DEFAULT => -134
	},
	{#State 221
		ACTIONS => {
			'PNULL' => 258,
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 259
		}
	},
	{#State 222
		DEFAULT => -176
	},
	{#State 223
		ACTIONS => {
			'PLUS_ASSIGN' => 270,
			'BOR_ASSIGN' => 269,
			'MINUS_ASSIGN' => 260,
			"[" => 261,
			'SHL_ASSIGN' => 262,
			'BXOR_ASSIGN' => 263,
			'DOT' => 264,
			'FDIV_ASSIGN' => 265,
			'SHR_ASSIGN' => 272,
			'MOD_ASSIGN' => 273,
			"=" => 274,
			'DIV_ASSIGN' => 275,
			'CONCAT_ASSIGN' => 266,
			'SHR_U_ASSIGN' => 267,
			'BAND_ASSIGN' => 268,
			'MUL_ASSIGN' => 276
		},
		DEFAULT => -240,
		GOTOS => {
			'assign_op' => 271
		}
	},
	{#State 224
		ACTIONS => {
			'PNULL' => 277,
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 278
		}
	},
	{#State 225
		DEFAULT => -237
	},
	{#State 226
		DEFAULT => -161
	},
	{#State 227
		ACTIONS => {
			"\n" => 279
		}
	},
	{#State 228
		DEFAULT => -191
	},
	{#State 229
		ACTIONS => {
			"\n" => 280
		}
	},
	{#State 230
		ACTIONS => {
			"(" => 281
		}
	},
	{#State 231
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'STRINGC' => 285,
			'VAR' => 73,
			'SREG' => 74,
			'REG' => 65
		},
		DEFAULT => -265,
		GOTOS => {
			'target' => 282,
			'reg' => 72,
			'targetlist' => 283,
			'result' => 284
		}
	},
	{#State 232
		ACTIONS => {
			"(" => 286
		}
	},
	{#State 233
		ACTIONS => {
			'IDENTIFIER' => 137,
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'INTC' => 61,
			'VAR' => 73,
			'USTRINGC' => 62,
			"[" => 136,
			'SREG' => 74,
			'PARROT_OP' => 141,
			'REG' => 65
		},
		DEFAULT => -284,
		GOTOS => {
			'var_or_i' => 131,
			'_var_or_i' => 138,
			'_vars' => 132,
			'label_op' => 133,
			'vars' => 287,
			'target' => 134,
			'reg' => 72,
			'const' => 71,
			'var' => 135
		}
	},
	{#State 234
		DEFAULT => -162
	},
	{#State 235
		DEFAULT => -167
	},
	{#State 236
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 288
		}
	},
	{#State 237
		DEFAULT => -267
	},
	{#State 238
		ACTIONS => {
			'INTV' => 36,
			'FLOATV' => 35,
			'STRINGV' => 34,
			'PMCV' => 38
		},
		GOTOS => {
			'type' => 289
		}
	},
	{#State 239
		ACTIONS => {
			"\n" => 290
		}
	},
	{#State 240
		DEFAULT => -238
	},
	{#State 241
		ACTIONS => {
			"(" => 291
		}
	},
	{#State 242
		DEFAULT => -133
	},
	{#State 243
		DEFAULT => -175
	},
	{#State 244
		DEFAULT => -239
	},
	{#State 245
		ACTIONS => {
			'STRINGC' => 292,
			'USTRINGC' => 293
		}
	},
	{#State 246
		ACTIONS => {
			'INTV' => 36,
			'FLOATV' => 35,
			'STRINGV' => 34,
			'PMCV' => 38
		},
		GOTOS => {
			'type' => 294
		}
	},
	{#State 247
		DEFAULT => -193
	},
	{#State 248
		DEFAULT => -266
	},
	{#State 249
		DEFAULT => -174
	},
	{#State 250
		ACTIONS => {
			'STRINGC' => 110,
			'INTV' => 36,
			'FLOATV' => 35,
			'STRINGV' => 34,
			'INTC' => 111,
			'PMCV' => 38
		},
		GOTOS => {
			'type' => 295
		}
	},
	{#State 251
		DEFAULT => -122
	},
	{#State 252
		ACTIONS => {
			"\n" => 296
		}
	},
	{#State 253
		DEFAULT => -173
	},
	{#State 254
		ACTIONS => {
			'IDENTIFIER' => 225,
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'STRINGC' => 240,
			'VAR' => 73,
			'USTRINGC' => 244,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 297,
			'reg' => 72,
			'the_sub' => 241,
			'sub_call' => 298
		}
	},
	{#State 255
		DEFAULT => -111,
		GOTOS => {
			'paramtype_list' => 299
		}
	},
	{#State 256
		DEFAULT => -16
	},
	{#State 257
		DEFAULT => -170
	},
	{#State 258
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 300
		}
	},
	{#State 259
		ACTIONS => {
			'RELOP_GTE' => 303,
			'GOTO' => 302,
			'COMMA' => 309,
			'RELOP_NE' => 308,
			'RELOP_GT' => 307,
			'RELOP_LT' => 305,
			'RELOP_EQ' => 306,
			'RELOP_LTE' => 310
		},
		GOTOS => {
			'relop' => 301,
			'comma_or_goto' => 304
		}
	},
	{#State 260
		DEFAULT => -224
	},
	{#State 261
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'_keylist' => 66,
			'keylist' => 311,
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 63,
			'key' => 58
		}
	},
	{#State 262
		DEFAULT => -234
	},
	{#State 263
		DEFAULT => -232
	},
	{#State 264
		ACTIONS => {
			'IDENTIFIER' => 30,
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'STRINGC' => 313,
			'VAR' => 73,
			'USTRINGC' => 314,
			'SREG' => 74,
			'PARROT_OP' => 33,
			'REG' => 65
		},
		GOTOS => {
			'target' => 312,
			'reg' => 72,
			'sub_label_op' => 315
		}
	},
	{#State 265
		DEFAULT => -228
	},
	{#State 266
		DEFAULT => -229
	},
	{#State 267
		DEFAULT => -235
	},
	{#State 268
		DEFAULT => -230
	},
	{#State 269
		DEFAULT => -231
	},
	{#State 270
		DEFAULT => -223
	},
	{#State 271
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 316
		}
	},
	{#State 272
		DEFAULT => -233
	},
	{#State 273
		DEFAULT => -227
	},
	{#State 274
		ACTIONS => {
			"-" => 317,
			"new" => 323,
			'PNULL' => 322,
			'IDENTIFIER' => 225,
			'PREG' => 67,
			'NREG' => 57,
			"~" => 318,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 324,
			"!" => 320,
			'INTC' => 61,
			'VAR' => 73,
			'USTRINGC' => 325,
			'SREG' => 74,
			'PARROT_OP' => 321,
			'REG' => 65
		},
		GOTOS => {
			'target' => 319,
			'reg' => 72,
			'un_op' => 327,
			'the_sub' => 241,
			'const' => 71,
			'sub_call' => 328,
			'var' => 326
		}
	},
	{#State 275
		DEFAULT => -226
	},
	{#State 276
		DEFAULT => -225
	},
	{#State 277
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 329
		}
	},
	{#State 278
		ACTIONS => {
			'RELOP_GTE' => 303,
			'GOTO' => 302,
			'COMMA' => 309,
			'RELOP_NE' => 308,
			'RELOP_GT' => 307,
			'RELOP_LT' => 305,
			'RELOP_EQ' => 306,
			'RELOP_LTE' => 310
		},
		GOTOS => {
			'relop' => 330,
			'comma_or_goto' => 331
		}
	},
	{#State 279
		DEFAULT => -124,
		GOTOS => {
			'pcc_returns' => 332
		}
	},
	{#State 280
		DEFAULT => -104,
		GOTOS => {
			'pcc_args' => 333
		}
	},
	{#State 281
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'STRINGC' => 285,
			'VAR' => 73,
			'SREG' => 74,
			'REG' => 65
		},
		DEFAULT => -265,
		GOTOS => {
			'target' => 282,
			'reg' => 72,
			'targetlist' => 334,
			'result' => 284
		}
	},
	{#State 282
		DEFAULT => -111,
		GOTOS => {
			'paramtype_list' => 335
		}
	},
	{#State 283
		ACTIONS => {
			'COMMA' => 337,
			")" => 336
		}
	},
	{#State 284
		DEFAULT => -263
	},
	{#State 285
		ACTIONS => {
			'ADV_ARROW' => 338
		}
	},
	{#State 286
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 341,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		DEFAULT => -135,
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'arg' => 339,
			'var' => 342,
			'var_returns' => 340
		}
	},
	{#State 287
		DEFAULT => -171
	},
	{#State 288
		DEFAULT => -172
	},
	{#State 289
		ACTIONS => {
			'IDENTIFIER' => 343
		}
	},
	{#State 290
		DEFAULT => -154
	},
	{#State 291
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 345,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		DEFAULT => -246,
		GOTOS => {
			'arglist' => 347,
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'arg' => 344,
			'var' => 346
		}
	},
	{#State 292
		ACTIONS => {
			'COMMA' => 348
		}
	},
	{#State 293
		ACTIONS => {
			'COMMA' => 349
		}
	},
	{#State 294
		ACTIONS => {
			'IDENTIFIER' => 350
		},
		GOTOS => {
			'id_list' => 351,
			'id_list_id' => 352
		}
	},
	{#State 295
		ACTIONS => {
			'IDENTIFIER' => 353
		}
	},
	{#State 296
		DEFAULT => -127,
		GOTOS => {
			'pcc_yields' => 354
		}
	},
	{#State 297
		ACTIONS => {
			'DOT' => 264
		},
		DEFAULT => -240
	},
	{#State 298
		DEFAULT => -169
	},
	{#State 299
		ACTIONS => {
			'ADV_OPTIONAL' => 358,
			'ADV_NAMED' => 356,
			'ADV_CALL_SIG' => 360,
			'UNIQUE_REG' => 357,
			'ADV_OPT_FLAG' => 359,
			'ADV_SLURPY' => 361
		},
		DEFAULT => -49,
		GOTOS => {
			'paramtype' => 355
		}
	},
	{#State 300
		ACTIONS => {
			'GOTO' => 362
		}
	},
	{#State 301
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 363
		}
	},
	{#State 302
		DEFAULT => -275
	},
	{#State 303
		DEFAULT => -279
	},
	{#State 304
		ACTIONS => {
			'IDENTIFIER' => 137,
			'PARROT_OP' => 141
		},
		GOTOS => {
			'label_op' => 364
		}
	},
	{#State 305
		DEFAULT => -280
	},
	{#State 306
		DEFAULT => -276
	},
	{#State 307
		DEFAULT => -278
	},
	{#State 308
		DEFAULT => -277
	},
	{#State 309
		DEFAULT => -274
	},
	{#State 310
		DEFAULT => -281
	},
	{#State 311
		ACTIONS => {
			"]" => 365
		}
	},
	{#State 312
		DEFAULT => -244
	},
	{#State 313
		DEFAULT => -243
	},
	{#State 314
		DEFAULT => -242
	},
	{#State 315
		DEFAULT => -241
	},
	{#State 316
		DEFAULT => -222
	},
	{#State 317
		DEFAULT => -197
	},
	{#State 318
		DEFAULT => -196
	},
	{#State 319
		ACTIONS => {
			'DOT' => 264,
			"(" => -240
		},
		DEFAULT => -300
	},
	{#State 320
		DEFAULT => -195
	},
	{#State 321
		ACTIONS => {
			'IDENTIFIER' => 137,
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'INTC' => 61,
			'VAR' => 73,
			'USTRINGC' => 62,
			"[" => 136,
			'SREG' => 74,
			'PARROT_OP' => 141,
			'REG' => 65
		},
		DEFAULT => -284,
		GOTOS => {
			'var_or_i' => 131,
			'_var_or_i' => 138,
			'_vars' => 132,
			'label_op' => 133,
			'vars' => 139,
			'pasm_args' => 366,
			'target' => 134,
			'reg' => 72,
			'const' => 71,
			'var' => 135
		}
	},
	{#State 322
		DEFAULT => -194
	},
	{#State 323
		ACTIONS => {
			'IDENTIFIER' => 367
		},
		GOTOS => {
			'classname' => 368
		}
	},
	{#State 324
		ACTIONS => {
			"(" => -238
		},
		DEFAULT => -314
	},
	{#State 325
		ACTIONS => {
			"(" => -239
		},
		DEFAULT => -315
	},
	{#State 326
		ACTIONS => {
			"-" => 369,
			"+" => 386,
			"~" => 370,
			'RELOP_NE' => 388,
			'RELOP_GT' => 387,
			"%" => 372,
			'LOG_XOR' => 371,
			'POW' => 373,
			'LOG_AND' => 374,
			'CONCAT' => 375,
			"*" => 376,
			'LOG_OR' => 377,
			"[" => 380,
			'SHIFT_LEFT' => 379,
			'SHIFT_RIGHT_U' => 378,
			'RELOP_GTE' => 381,
			"&" => 389,
			'SHIFT_RIGHT' => 382,
			"/" => 391,
			'FDIV' => 390,
			"|" => 383,
			'RELOP_LT' => 384,
			'RELOP_LTE' => 393,
			'RELOP_EQ' => 385
		},
		DEFAULT => -183,
		GOTOS => {
			'bin_op' => 392
		}
	},
	{#State 327
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 394
		}
	},
	{#State 328
		DEFAULT => -189
	},
	{#State 329
		ACTIONS => {
			'GOTO' => 395
		}
	},
	{#State 330
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 396
		}
	},
	{#State 331
		ACTIONS => {
			'IDENTIFIER' => 137,
			'PARROT_OP' => 141
		},
		GOTOS => {
			'label_op' => 397
		}
	},
	{#State 332
		ACTIONS => {
			'PCC_END_RETURN' => 398,
			"\n" => 401,
			'SET_RETURN' => 399
		},
		GOTOS => {
			'pcc_return' => 400
		}
	},
	{#State 333
		ACTIONS => {
			'INVOCANT' => 402,
			'ARG' => 405
		},
		DEFAULT => -77,
		GOTOS => {
			'pcc_arg' => 404,
			'opt_invocant' => 403
		}
	},
	{#State 334
		ACTIONS => {
			'COMMA' => 337,
			")" => 406
		}
	},
	{#State 335
		ACTIONS => {
			'ADV_OPTIONAL' => 358,
			'ADV_NAMED' => 356,
			'ADV_CALL_SIG' => 360,
			'UNIQUE_REG' => 357,
			'ADV_OPT_FLAG' => 359,
			'ADV_SLURPY' => 361
		},
		DEFAULT => -260,
		GOTOS => {
			'paramtype' => 355
		}
	},
	{#State 336
		ACTIONS => {
			"=" => 407
		}
	},
	{#State 337
		ACTIONS => {
			'STRINGC' => 409,
			'PREG' => 67,
			'NREG' => 57,
			'VAR' => 73,
			'SREG' => 74,
			'IREG' => 68,
			'REG' => 65
		},
		GOTOS => {
			'target' => 282,
			'reg' => 72,
			'result' => 408
		}
	},
	{#State 338
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'VAR' => 73,
			'SREG' => 74,
			'IREG' => 68,
			'REG' => 65
		},
		GOTOS => {
			'target' => 410,
			'reg' => 72
		}
	},
	{#State 339
		DEFAULT => -136
	},
	{#State 340
		ACTIONS => {
			'COMMA' => 412,
			")" => 411
		}
	},
	{#State 341
		ACTIONS => {
			'ADV_ARROW' => 413
		},
		DEFAULT => -314
	},
	{#State 342
		DEFAULT => -253,
		GOTOS => {
			'argtype_list' => 414
		}
	},
	{#State 343
		ACTIONS => {
			"=" => 415
		}
	},
	{#State 344
		DEFAULT => -248
	},
	{#State 345
		ACTIONS => {
			'ADV_ARROW' => 416
		},
		DEFAULT => -314
	},
	{#State 346
		ACTIONS => {
			'ADV_ARROW' => 417
		},
		DEFAULT => -253,
		GOTOS => {
			'argtype_list' => 414
		}
	},
	{#State 347
		ACTIONS => {
			'COMMA' => 419,
			")" => 418
		}
	},
	{#State 348
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'VAR' => 73,
			'SREG' => 74,
			'IREG' => 68,
			'REG' => 65
		},
		GOTOS => {
			'target' => 420,
			'reg' => 72
		}
	},
	{#State 349
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'VAR' => 73,
			'SREG' => 74,
			'IREG' => 68,
			'REG' => 65
		},
		GOTOS => {
			'target' => 421,
			'reg' => 72
		}
	},
	{#State 350
		ACTIONS => {
			'UNIQUE_REG' => 422
		},
		DEFAULT => -159,
		GOTOS => {
			'opt_unique_reg' => 423
		}
	},
	{#State 351
		ACTIONS => {
			'COMMA' => 424
		},
		DEFAULT => -163
	},
	{#State 352
		DEFAULT => -156
	},
	{#State 353
		ACTIONS => {
			"=" => 425
		}
	},
	{#State 354
		ACTIONS => {
			'PCC_END_YIELD' => 427,
			'SET_YIELD' => 429,
			"\n" => 428
		},
		GOTOS => {
			'pcc_set_yield' => 426
		}
	},
	{#State 355
		DEFAULT => -112
	},
	{#State 356
		ACTIONS => {
			"(" => 430
		},
		DEFAULT => -116
	},
	{#State 357
		DEFAULT => -119
	},
	{#State 358
		DEFAULT => -114
	},
	{#State 359
		DEFAULT => -115
	},
	{#State 360
		DEFAULT => -120
	},
	{#State 361
		DEFAULT => -113
	},
	{#State 362
		ACTIONS => {
			'IDENTIFIER' => 137,
			'PARROT_OP' => 141
		},
		GOTOS => {
			'label_op' => 431
		}
	},
	{#State 363
		ACTIONS => {
			'GOTO' => 432
		}
	},
	{#State 364
		DEFAULT => -270
	},
	{#State 365
		ACTIONS => {
			"=" => 433
		}
	},
	{#State 366
		DEFAULT => -236
	},
	{#State 367
		DEFAULT => -182
	},
	{#State 368
		ACTIONS => {
			"[" => 434
		}
	},
	{#State 369
		DEFAULT => -198
	},
	{#State 370
		DEFAULT => -220
	},
	{#State 371
		DEFAULT => -217
	},
	{#State 372
		DEFAULT => -202
	},
	{#State 373
		DEFAULT => -204
	},
	{#State 374
		DEFAULT => -215
	},
	{#State 375
		DEFAULT => -205
	},
	{#State 376
		DEFAULT => -200
	},
	{#State 377
		DEFAULT => -216
	},
	{#State 378
		DEFAULT => -214
	},
	{#State 379
		DEFAULT => -212
	},
	{#State 380
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'_keylist' => 66,
			'keylist' => 435,
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 63,
			'key' => 58
		}
	},
	{#State 381
		DEFAULT => -209
	},
	{#State 382
		DEFAULT => -213
	},
	{#State 383
		DEFAULT => -219
	},
	{#State 384
		DEFAULT => -210
	},
	{#State 385
		DEFAULT => -206
	},
	{#State 386
		DEFAULT => -199
	},
	{#State 387
		DEFAULT => -208
	},
	{#State 388
		DEFAULT => -207
	},
	{#State 389
		DEFAULT => -218
	},
	{#State 390
		DEFAULT => -203
	},
	{#State 391
		DEFAULT => -201
	},
	{#State 392
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 436
		}
	},
	{#State 393
		DEFAULT => -211
	},
	{#State 394
		DEFAULT => -184
	},
	{#State 395
		ACTIONS => {
			'IDENTIFIER' => 137,
			'PARROT_OP' => 141
		},
		GOTOS => {
			'label_op' => 437
		}
	},
	{#State 396
		ACTIONS => {
			'GOTO' => 438
		}
	},
	{#State 397
		DEFAULT => -271
	},
	{#State 398
		DEFAULT => -121
	},
	{#State 399
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 439
		}
	},
	{#State 400
		ACTIONS => {
			"\n" => 440
		}
	},
	{#State 401
		DEFAULT => -125
	},
	{#State 402
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 441
		}
	},
	{#State 403
		ACTIONS => {
			'NCI_CALL' => 442,
			'PCC_CALL' => 445,
			'METH_CALL' => 443
		},
		GOTOS => {
			'pcc_call' => 444
		}
	},
	{#State 404
		ACTIONS => {
			"\n" => 446
		}
	},
	{#State 405
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'arg' => 447,
			'var' => 342
		}
	},
	{#State 406
		DEFAULT => -221
	},
	{#State 407
		ACTIONS => {
			'IDENTIFIER' => 225,
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'STRINGC' => 240,
			'VAR' => 73,
			'USTRINGC' => 244,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 297,
			'reg' => 72,
			'the_sub' => 448
		}
	},
	{#State 408
		DEFAULT => -261
	},
	{#State 409
		ACTIONS => {
			'ADV_ARROW' => 449
		}
	},
	{#State 410
		DEFAULT => -264
	},
	{#State 411
		DEFAULT => -132
	},
	{#State 412
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 451,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'arg' => 450,
			'var' => 342
		}
	},
	{#State 413
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 452
		}
	},
	{#State 414
		ACTIONS => {
			'ADV_CALL_SIG' => 456,
			'ADV_FLAT' => 453,
			'ADV_NAMED' => 455
		},
		DEFAULT => -252,
		GOTOS => {
			'argtype' => 454
		}
	},
	{#State 415
		ACTIONS => {
			'FLOATC' => 69,
			'STRINGC' => 59,
			'INTC' => 61,
			'USTRINGC' => 62
		},
		GOTOS => {
			'const' => 457
		}
	},
	{#State 416
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 458
		}
	},
	{#State 417
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 459
		}
	},
	{#State 418
		DEFAULT => -245
	},
	{#State 419
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 461,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'arg' => 460,
			'var' => 342
		}
	},
	{#State 420
		DEFAULT => -164
	},
	{#State 421
		DEFAULT => -165
	},
	{#State 422
		DEFAULT => -160
	},
	{#State 423
		DEFAULT => -158
	},
	{#State 424
		ACTIONS => {
			'IDENTIFIER' => 350
		},
		GOTOS => {
			'id_list_id' => 462
		}
	},
	{#State 425
		ACTIONS => {
			'FLOATC' => 69,
			'STRINGC' => 59,
			'INTC' => 61,
			'USTRINGC' => 62
		},
		GOTOS => {
			'const' => 463
		}
	},
	{#State 426
		ACTIONS => {
			"\n" => 464
		}
	},
	{#State 427
		DEFAULT => -123
	},
	{#State 428
		DEFAULT => -128
	},
	{#State 429
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 465
		}
	},
	{#State 430
		ACTIONS => {
			'STRINGC' => 466,
			'USTRINGC' => 467
		}
	},
	{#State 431
		DEFAULT => -269
	},
	{#State 432
		ACTIONS => {
			'IDENTIFIER' => 137,
			'PARROT_OP' => 141
		},
		GOTOS => {
			'label_op' => 468
		}
	},
	{#State 433
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 469
		}
	},
	{#State 434
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'_keylist' => 66,
			'keylist' => 470,
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 63,
			'key' => 58
		}
	},
	{#State 435
		ACTIONS => {
			"]" => 471
		}
	},
	{#State 436
		DEFAULT => -185
	},
	{#State 437
		DEFAULT => -273
	},
	{#State 438
		ACTIONS => {
			'IDENTIFIER' => 137,
			'PARROT_OP' => 141
		},
		GOTOS => {
			'label_op' => 472
		}
	},
	{#State 439
		DEFAULT => -253,
		GOTOS => {
			'argtype_list' => 473
		}
	},
	{#State 440
		DEFAULT => -126
	},
	{#State 441
		ACTIONS => {
			"\n" => 474
		}
	},
	{#State 442
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 475
		}
	},
	{#State 443
		ACTIONS => {
			'STRINGC' => 477,
			'PREG' => 67,
			'NREG' => 57,
			'VAR' => 73,
			'SREG' => 74,
			'IREG' => 68,
			'REG' => 65
		},
		GOTOS => {
			'target' => 476,
			'reg' => 72
		}
	},
	{#State 444
		ACTIONS => {
			'LABEL' => 41
		},
		DEFAULT => -75,
		GOTOS => {
			'opt_label' => 478,
			'label' => 479
		}
	},
	{#State 445
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 480
		}
	},
	{#State 446
		DEFAULT => -105
	},
	{#State 447
		DEFAULT => -106
	},
	{#State 448
		ACTIONS => {
			"(" => 481
		}
	},
	{#State 449
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'VAR' => 73,
			'SREG' => 74,
			'IREG' => 68,
			'REG' => 65
		},
		GOTOS => {
			'target' => 482,
			'reg' => 72
		}
	},
	{#State 450
		DEFAULT => -138
	},
	{#State 451
		ACTIONS => {
			'ADV_ARROW' => 483
		},
		DEFAULT => -314
	},
	{#State 452
		DEFAULT => -137
	},
	{#State 453
		DEFAULT => -255
	},
	{#State 454
		DEFAULT => -254
	},
	{#State 455
		ACTIONS => {
			"(" => 484
		},
		DEFAULT => -256
	},
	{#State 456
		DEFAULT => -257
	},
	{#State 457
		DEFAULT => -168
	},
	{#State 458
		DEFAULT => -251
	},
	{#State 459
		DEFAULT => -250
	},
	{#State 460
		DEFAULT => -247
	},
	{#State 461
		ACTIONS => {
			'ADV_ARROW' => 485
		},
		DEFAULT => -314
	},
	{#State 462
		DEFAULT => -157
	},
	{#State 463
		DEFAULT => -166
	},
	{#State 464
		DEFAULT => -129
	},
	{#State 465
		DEFAULT => -253,
		GOTOS => {
			'argtype_list' => 486
		}
	},
	{#State 466
		ACTIONS => {
			")" => 487
		}
	},
	{#State 467
		ACTIONS => {
			")" => 488
		}
	},
	{#State 468
		DEFAULT => -268
	},
	{#State 469
		DEFAULT => -187
	},
	{#State 470
		ACTIONS => {
			"]" => 489
		}
	},
	{#State 471
		DEFAULT => -186
	},
	{#State 472
		DEFAULT => -272
	},
	{#State 473
		ACTIONS => {
			'ADV_CALL_SIG' => 456,
			'ADV_FLAT' => 453,
			'ADV_NAMED' => 455
		},
		DEFAULT => -130,
		GOTOS => {
			'argtype' => 454
		}
	},
	{#State 474
		DEFAULT => -78
	},
	{#State 475
		ACTIONS => {
			"\n" => 490
		}
	},
	{#State 476
		ACTIONS => {
			"\n" => 491,
			'COMMA' => 492
		}
	},
	{#State 477
		ACTIONS => {
			"\n" => 493,
			'COMMA' => 494
		}
	},
	{#State 478
		DEFAULT => -107,
		GOTOS => {
			'pcc_results' => 495
		}
	},
	{#State 479
		ACTIONS => {
			"\n" => 496
		}
	},
	{#State 480
		ACTIONS => {
			"\n" => 497,
			'COMMA' => 498
		}
	},
	{#State 481
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 345,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		DEFAULT => -246,
		GOTOS => {
			'arglist' => 499,
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'arg' => 344,
			'var' => 346
		}
	},
	{#State 482
		DEFAULT => -262
	},
	{#State 483
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 500
		}
	},
	{#State 484
		ACTIONS => {
			'STRINGC' => 501,
			'USTRINGC' => 502
		}
	},
	{#State 485
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 503
		}
	},
	{#State 486
		ACTIONS => {
			'ADV_CALL_SIG' => 456,
			'ADV_FLAT' => 453,
			'ADV_NAMED' => 455
		},
		DEFAULT => -131,
		GOTOS => {
			'argtype' => 454
		}
	},
	{#State 487
		DEFAULT => -117
	},
	{#State 488
		DEFAULT => -118
	},
	{#State 489
		DEFAULT => -188
	},
	{#State 490
		DEFAULT => -99
	},
	{#State 491
		DEFAULT => -100
	},
	{#State 492
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 504
		}
	},
	{#State 493
		DEFAULT => -101
	},
	{#State 494
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 505
		}
	},
	{#State 495
		ACTIONS => {
			'RESULT' => 506,
			'PCC_END' => 509,
			'LOCAL' => 508
		},
		GOTOS => {
			'pcc_result' => 507
		}
	},
	{#State 496
		DEFAULT => -76
	},
	{#State 497
		DEFAULT => -98
	},
	{#State 498
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'IREG' => 68,
			'FLOATC' => 69,
			'STRINGC' => 59,
			'VAR' => 73,
			'INTC' => 61,
			'USTRINGC' => 62,
			'SREG' => 74,
			'REG' => 65
		},
		GOTOS => {
			'target' => 60,
			'reg' => 72,
			'const' => 71,
			'var' => 510
		}
	},
	{#State 499
		ACTIONS => {
			'COMMA' => 419,
			")" => 511
		}
	},
	{#State 500
		DEFAULT => -139
	},
	{#State 501
		ACTIONS => {
			")" => 512
		}
	},
	{#State 502
		ACTIONS => {
			")" => 513
		}
	},
	{#State 503
		DEFAULT => -249
	},
	{#State 504
		ACTIONS => {
			"\n" => 514
		}
	},
	{#State 505
		ACTIONS => {
			"\n" => 515
		}
	},
	{#State 506
		ACTIONS => {
			'PREG' => 67,
			'NREG' => 57,
			'VAR' => 73,
			'SREG' => 74,
			'IREG' => 68,
			'REG' => 65
		},
		GOTOS => {
			'target' => 516,
			'reg' => 72
		}
	},
	{#State 507
		ACTIONS => {
			"\n" => 517
		}
	},
	{#State 508
		ACTIONS => {
			'INTV' => 36,
			'FLOATV' => 35,
			'STRINGV' => 34,
			'PMCV' => 38
		},
		GOTOS => {
			'type' => 518
		}
	},
	{#State 509
		DEFAULT => -74
	},
	{#State 510
		ACTIONS => {
			"\n" => 519
		}
	},
	{#State 511
		DEFAULT => -190
	},
	{#State 512
		DEFAULT => -259
	},
	{#State 513
		DEFAULT => -258
	},
	{#State 514
		DEFAULT => -102
	},
	{#State 515
		DEFAULT => -103
	},
	{#State 516
		DEFAULT => -111,
		GOTOS => {
			'paramtype_list' => 520
		}
	},
	{#State 517
		DEFAULT => -108
	},
	{#State 518
		ACTIONS => {
			'IDENTIFIER' => 350
		},
		GOTOS => {
			'id_list_id' => 521
		}
	},
	{#State 519
		DEFAULT => -97
	},
	{#State 520
		ACTIONS => {
			'ADV_OPTIONAL' => 358,
			'ADV_NAMED' => 356,
			'ADV_CALL_SIG' => 360,
			'UNIQUE_REG' => 357,
			'ADV_OPT_FLAG' => 359,
			'ADV_SLURPY' => 361
		},
		DEFAULT => -109,
		GOTOS => {
			'paramtype' => 355
		}
	},
	{#State 521
		DEFAULT => -110
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 4140 ./PIR.pm
	],
	[#Rule program_1
		 'program', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4147 ./PIR.pm
	],
	[#Rule compilation_units_2
		 'compilation_units', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4154 ./PIR.pm
	],
	[#Rule compilation_units_3
		 'compilation_units', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4161 ./PIR.pm
	],
	[#Rule compilation_unit_4
		 'compilation_unit', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4168 ./PIR.pm
	],
	[#Rule compilation_unit_5
		 'compilation_unit', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4175 ./PIR.pm
	],
	[#Rule compilation_unit_6
		 'compilation_unit', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4182 ./PIR.pm
	],
	[#Rule compilation_unit_7
		 'compilation_unit', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4189 ./PIR.pm
	],
	[#Rule compilation_unit_8
		 'compilation_unit', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4196 ./PIR.pm
	],
	[#Rule compilation_unit_9
		 'compilation_unit', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4203 ./PIR.pm
	],
	[#Rule compilation_unit_10
		 'compilation_unit', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4210 ./PIR.pm
	],
	[#Rule compilation_unit_11
		 'compilation_unit', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4217 ./PIR.pm
	],
	[#Rule pragma_12
		 'pragma', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4224 ./PIR.pm
	],
	[#Rule pragma_13
		 'pragma', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4231 ./PIR.pm
	],
	[#Rule location_directive_14
		 'location_directive', 5,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4238 ./PIR.pm
	],
	[#Rule location_directive_15
		 'location_directive', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4245 ./PIR.pm
	],
	[#Rule annotate_directive_16
		 'annotate_directive', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4252 ./PIR.pm
	],
	[#Rule hll_def_17
		 'hll_def', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4259 ./PIR.pm
	],
	[#Rule constdef_18
		 'constdef', 5,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4266 ./PIR.pm
	],
	[#Rule pmc_const_19
		 'pmc_const', 5,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4273 ./PIR.pm
	],
	[#Rule pmc_const_20
		 'pmc_const', 5,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4280 ./PIR.pm
	],
	[#Rule any_string_21
		 'any_string', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4287 ./PIR.pm
	],
	[#Rule any_string_22
		 'any_string', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4294 ./PIR.pm
	],
	[#Rule pasmcode_23
		 'pasmcode', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4301 ./PIR.pm
	],
	[#Rule pasmcode_24
		 'pasmcode', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4308 ./PIR.pm
	],
	[#Rule pasmline_25
		 'pasmline', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4315 ./PIR.pm
	],
	[#Rule pasmline_26
		 'pasmline', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4322 ./PIR.pm
	],
	[#Rule pasmline_27
		 'pasmline', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4329 ./PIR.pm
	],
	[#Rule pasmline_28
		 'pasmline', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4336 ./PIR.pm
	],
	[#Rule pasmline_29
		 'pasmline', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4343 ./PIR.pm
	],
	[#Rule pasmline_30
		 'pasmline', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4350 ./PIR.pm
	],
	[#Rule pasmline_31
		 'pasmline', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4357 ./PIR.pm
	],
	[#Rule pasm_inst_32
		 'pasm_inst', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4364 ./PIR.pm
	],
	[#Rule pasm_inst_33
		 'pasm_inst', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4371 ./PIR.pm
	],
	[#Rule pasm_inst_34
		 'pasm_inst', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4378 ./PIR.pm
	],
	[#Rule pasm_inst_35
		 'pasm_inst', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4385 ./PIR.pm
	],
	[#Rule pasm_inst_36
		 'pasm_inst', 0,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4392 ./PIR.pm
	],
	[#Rule pasm_args_37
		 'pasm_args', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4399 ./PIR.pm
	],
	[#Rule emit_38
		 'emit', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4406 ./PIR.pm
	],
	[#Rule opt_pasmcode_39
		 'opt_pasmcode', 0,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4413 ./PIR.pm
	],
	[#Rule opt_pasmcode_40
		 'opt_pasmcode', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4420 ./PIR.pm
	],
	[#Rule class_namespace_41
		 'class_namespace', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4427 ./PIR.pm
	],
	[#Rule maybe_ns_42
		 'maybe_ns', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4434 ./PIR.pm
	],
	[#Rule maybe_ns_43
		 'maybe_ns', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4441 ./PIR.pm
	],
	[#Rule sub_44
		 'sub', 7,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4448 ./PIR.pm
	],
	[#Rule sub_params_45
		 'sub_params', 0,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4455 ./PIR.pm
	],
	[#Rule sub_params_46
		 'sub_params', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4462 ./PIR.pm
	],
	[#Rule sub_params_47
		 'sub_params', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4469 ./PIR.pm
	],
	[#Rule sub_param_48
		 'sub_param', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4476 ./PIR.pm
	],
	[#Rule sub_param_type_def_49
		 'sub_param_type_def', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4483 ./PIR.pm
	],
	[#Rule multi_50
		 'multi', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4490 ./PIR.pm
	],
	[#Rule outer_51
		 'outer', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4497 ./PIR.pm
	],
	[#Rule outer_52
		 'outer', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4504 ./PIR.pm
	],
	[#Rule vtable_53
		 'vtable', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4511 ./PIR.pm
	],
	[#Rule vtable_54
		 'vtable', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4518 ./PIR.pm
	],
	[#Rule method_55
		 'method', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4525 ./PIR.pm
	],
	[#Rule method_56
		 'method', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4532 ./PIR.pm
	],
	[#Rule ns_entry_name_57
		 'ns_entry_name', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4539 ./PIR.pm
	],
	[#Rule ns_entry_name_58
		 'ns_entry_name', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4546 ./PIR.pm
	],
	[#Rule instanceof_59
		 'instanceof', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4553 ./PIR.pm
	],
	[#Rule subid_60
		 'subid', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4560 ./PIR.pm
	],
	[#Rule subid_61
		 'subid', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4567 ./PIR.pm
	],
	[#Rule multi_types_62
		 'multi_types', 0,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4574 ./PIR.pm
	],
	[#Rule multi_types_63
		 'multi_types', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4581 ./PIR.pm
	],
	[#Rule multi_types_64
		 'multi_types', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4588 ./PIR.pm
	],
	[#Rule multi_type_65
		 'multi_type', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4595 ./PIR.pm
	],
	[#Rule multi_type_66
		 'multi_type', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4602 ./PIR.pm
	],
	[#Rule multi_type_67
		 'multi_type', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4609 ./PIR.pm
	],
	[#Rule multi_type_68
		 'multi_type', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4616 ./PIR.pm
	],
	[#Rule multi_type_69
		 'multi_type', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4623 ./PIR.pm
	],
	[#Rule multi_type_70
		 'multi_type', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4630 ./PIR.pm
	],
	[#Rule multi_type_71
		 'multi_type', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4637 ./PIR.pm
	],
	[#Rule sub_body_72
		 'sub_body', 0,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4644 ./PIR.pm
	],
	[#Rule sub_body_73
		 'sub_body', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4651 ./PIR.pm
	],
	[#Rule pcc_sub_call_74
		 'pcc_sub_call', 8,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4658 ./PIR.pm
	],
	[#Rule opt_label_75
		 'opt_label', 0,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4665 ./PIR.pm
	],
	[#Rule opt_label_76
		 'opt_label', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4672 ./PIR.pm
	],
	[#Rule opt_invocant_77
		 'opt_invocant', 0,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4679 ./PIR.pm
	],
	[#Rule opt_invocant_78
		 'opt_invocant', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4686 ./PIR.pm
	],
	[#Rule sub_proto_79
		 'sub_proto', 0,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4693 ./PIR.pm
	],
	[#Rule sub_proto_80
		 'sub_proto', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4700 ./PIR.pm
	],
	[#Rule sub_proto_list_81
		 'sub_proto_list', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4707 ./PIR.pm
	],
	[#Rule sub_proto_list_82
		 'sub_proto_list', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4714 ./PIR.pm
	],
	[#Rule proto_83
		 'proto', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4721 ./PIR.pm
	],
	[#Rule proto_84
		 'proto', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4728 ./PIR.pm
	],
	[#Rule proto_85
		 'proto', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4735 ./PIR.pm
	],
	[#Rule proto_86
		 'proto', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4742 ./PIR.pm
	],
	[#Rule proto_87
		 'proto', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4749 ./PIR.pm
	],
	[#Rule proto_88
		 'proto', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4756 ./PIR.pm
	],
	[#Rule proto_89
		 'proto', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4763 ./PIR.pm
	],
	[#Rule proto_90
		 'proto', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4770 ./PIR.pm
	],
	[#Rule proto_91
		 'proto', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4777 ./PIR.pm
	],
	[#Rule proto_92
		 'proto', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4784 ./PIR.pm
	],
	[#Rule proto_93
		 'proto', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4791 ./PIR.pm
	],
	[#Rule proto_94
		 'proto', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4798 ./PIR.pm
	],
	[#Rule proto_95
		 'proto', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4805 ./PIR.pm
	],
	[#Rule proto_96
		 'proto', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4812 ./PIR.pm
	],
	[#Rule pcc_call_97
		 'pcc_call', 5,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4819 ./PIR.pm
	],
	[#Rule pcc_call_98
		 'pcc_call', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4826 ./PIR.pm
	],
	[#Rule pcc_call_99
		 'pcc_call', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4833 ./PIR.pm
	],
	[#Rule pcc_call_100
		 'pcc_call', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4840 ./PIR.pm
	],
	[#Rule pcc_call_101
		 'pcc_call', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4847 ./PIR.pm
	],
	[#Rule pcc_call_102
		 'pcc_call', 5,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4854 ./PIR.pm
	],
	[#Rule pcc_call_103
		 'pcc_call', 5,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4861 ./PIR.pm
	],
	[#Rule pcc_args_104
		 'pcc_args', 0,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4868 ./PIR.pm
	],
	[#Rule pcc_args_105
		 'pcc_args', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4875 ./PIR.pm
	],
	[#Rule pcc_arg_106
		 'pcc_arg', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4882 ./PIR.pm
	],
	[#Rule pcc_results_107
		 'pcc_results', 0,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4889 ./PIR.pm
	],
	[#Rule pcc_results_108
		 'pcc_results', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4896 ./PIR.pm
	],
	[#Rule pcc_result_109
		 'pcc_result', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4903 ./PIR.pm
	],
	[#Rule pcc_result_110
		 'pcc_result', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4910 ./PIR.pm
	],
	[#Rule paramtype_list_111
		 'paramtype_list', 0,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4917 ./PIR.pm
	],
	[#Rule paramtype_list_112
		 'paramtype_list', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4924 ./PIR.pm
	],
	[#Rule paramtype_113
		 'paramtype', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4931 ./PIR.pm
	],
	[#Rule paramtype_114
		 'paramtype', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4938 ./PIR.pm
	],
	[#Rule paramtype_115
		 'paramtype', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4945 ./PIR.pm
	],
	[#Rule paramtype_116
		 'paramtype', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4952 ./PIR.pm
	],
	[#Rule paramtype_117
		 'paramtype', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4959 ./PIR.pm
	],
	[#Rule paramtype_118
		 'paramtype', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4966 ./PIR.pm
	],
	[#Rule paramtype_119
		 'paramtype', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4973 ./PIR.pm
	],
	[#Rule paramtype_120
		 'paramtype', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4980 ./PIR.pm
	],
	[#Rule pcc_ret_121
		 'pcc_ret', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4987 ./PIR.pm
	],
	[#Rule pcc_ret_122
		 'pcc_ret', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4994 ./PIR.pm
	],
	[#Rule pcc_yield_123
		 'pcc_yield', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5001 ./PIR.pm
	],
	[#Rule pcc_returns_124
		 'pcc_returns', 0,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5008 ./PIR.pm
	],
	[#Rule pcc_returns_125
		 'pcc_returns', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5015 ./PIR.pm
	],
	[#Rule pcc_returns_126
		 'pcc_returns', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5022 ./PIR.pm
	],
	[#Rule pcc_yields_127
		 'pcc_yields', 0,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5029 ./PIR.pm
	],
	[#Rule pcc_yields_128
		 'pcc_yields', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5036 ./PIR.pm
	],
	[#Rule pcc_yields_129
		 'pcc_yields', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5043 ./PIR.pm
	],
	[#Rule pcc_return_130
		 'pcc_return', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5050 ./PIR.pm
	],
	[#Rule pcc_set_yield_131
		 'pcc_set_yield', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5057 ./PIR.pm
	],
	[#Rule pcc_return_many_132
		 'pcc_return_many', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5064 ./PIR.pm
	],
	[#Rule return_or_yield_133
		 'return_or_yield', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5071 ./PIR.pm
	],
	[#Rule return_or_yield_134
		 'return_or_yield', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5078 ./PIR.pm
	],
	[#Rule var_returns_135
		 'var_returns', 0,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5085 ./PIR.pm
	],
	[#Rule var_returns_136
		 'var_returns', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5092 ./PIR.pm
	],
	[#Rule var_returns_137
		 'var_returns', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5099 ./PIR.pm
	],
	[#Rule var_returns_138
		 'var_returns', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5106 ./PIR.pm
	],
	[#Rule var_returns_139
		 'var_returns', 5,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5113 ./PIR.pm
	],
	[#Rule statements_140
		 'statements', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5120 ./PIR.pm
	],
	[#Rule statements_141
		 'statements', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5127 ./PIR.pm
	],
	[#Rule helper_clear_state_142
		 'helper_clear_state', 0,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5134 ./PIR.pm
	],
	[#Rule statement_143
		 'statement', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5141 ./PIR.pm
	],
	[#Rule statement_144
		 'statement', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5148 ./PIR.pm
	],
	[#Rule statement_145
		 'statement', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5155 ./PIR.pm
	],
	[#Rule statement_146
		 'statement', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5162 ./PIR.pm
	],
	[#Rule statement_147
		 'statement', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5169 ./PIR.pm
	],
	[#Rule statement_148
		 'statement', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5176 ./PIR.pm
	],
	[#Rule labels_149
		 'labels', 0,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5183 ./PIR.pm
	],
	[#Rule labels_150
		 'labels', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5190 ./PIR.pm
	],
	[#Rule _labels_151
		 '_labels', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5197 ./PIR.pm
	],
	[#Rule _labels_152
		 '_labels', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5204 ./PIR.pm
	],
	[#Rule label_153
		 'label', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5211 ./PIR.pm
	],
	[#Rule instruction_154
		 'instruction', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5218 ./PIR.pm
	],
	[#Rule instruction_155
		 'instruction', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5225 ./PIR.pm
	],
	[#Rule id_list_156
		 'id_list', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5232 ./PIR.pm
	],
	[#Rule id_list_157
		 'id_list', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5239 ./PIR.pm
	],
	[#Rule id_list_id_158
		 'id_list_id', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5246 ./PIR.pm
	],
	[#Rule opt_unique_reg_159
		 'opt_unique_reg', 0,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5253 ./PIR.pm
	],
	[#Rule opt_unique_reg_160
		 'opt_unique_reg', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5260 ./PIR.pm
	],
	[#Rule labeled_inst_161
		 'labeled_inst', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5267 ./PIR.pm
	],
	[#Rule labeled_inst_162
		 'labeled_inst', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5274 ./PIR.pm
	],
	[#Rule labeled_inst_163
		 'labeled_inst', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5281 ./PIR.pm
	],
	[#Rule labeled_inst_164
		 'labeled_inst', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5288 ./PIR.pm
	],
	[#Rule labeled_inst_165
		 'labeled_inst', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5295 ./PIR.pm
	],
	[#Rule labeled_inst_166
		 'labeled_inst', 5,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5302 ./PIR.pm
	],
	[#Rule labeled_inst_167
		 'labeled_inst', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5309 ./PIR.pm
	],
	[#Rule labeled_inst_168
		 'labeled_inst', 5,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5316 ./PIR.pm
	],
	[#Rule labeled_inst_169
		 'labeled_inst', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5323 ./PIR.pm
	],
	[#Rule labeled_inst_170
		 'labeled_inst', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5330 ./PIR.pm
	],
	[#Rule labeled_inst_171
		 'labeled_inst', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5337 ./PIR.pm
	],
	[#Rule labeled_inst_172
		 'labeled_inst', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5344 ./PIR.pm
	],
	[#Rule labeled_inst_173
		 'labeled_inst', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5351 ./PIR.pm
	],
	[#Rule labeled_inst_174
		 'labeled_inst', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5358 ./PIR.pm
	],
	[#Rule labeled_inst_175
		 'labeled_inst', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5365 ./PIR.pm
	],
	[#Rule labeled_inst_176
		 'labeled_inst', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5372 ./PIR.pm
	],
	[#Rule labeled_inst_177
		 'labeled_inst', 0,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5379 ./PIR.pm
	],
	[#Rule type_178
		 'type', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5386 ./PIR.pm
	],
	[#Rule type_179
		 'type', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5393 ./PIR.pm
	],
	[#Rule type_180
		 'type', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5400 ./PIR.pm
	],
	[#Rule type_181
		 'type', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5407 ./PIR.pm
	],
	[#Rule classname_182
		 'classname', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5414 ./PIR.pm
	],
	[#Rule assignment_183
		 'assignment', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5421 ./PIR.pm
	],
	[#Rule assignment_184
		 'assignment', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5428 ./PIR.pm
	],
	[#Rule assignment_185
		 'assignment', 5,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5435 ./PIR.pm
	],
	[#Rule assignment_186
		 'assignment', 6,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5442 ./PIR.pm
	],
	[#Rule assignment_187
		 'assignment', 6,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5449 ./PIR.pm
	],
	[#Rule assignment_188
		 'assignment', 7,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5456 ./PIR.pm
	],
	[#Rule assignment_189
		 'assignment', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5463 ./PIR.pm
	],
	[#Rule assignment_190
		 'assignment', 8,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5470 ./PIR.pm
	],
	[#Rule assignment_191
		 'assignment', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5477 ./PIR.pm
	],
	[#Rule assignment_192
		 'assignment', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5484 ./PIR.pm
	],
	[#Rule assignment_193
		 'assignment', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5491 ./PIR.pm
	],
	[#Rule assignment_194
		 'assignment', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5498 ./PIR.pm
	],
	[#Rule un_op_195
		 'un_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5505 ./PIR.pm
	],
	[#Rule un_op_196
		 'un_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5512 ./PIR.pm
	],
	[#Rule un_op_197
		 'un_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5519 ./PIR.pm
	],
	[#Rule bin_op_198
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5526 ./PIR.pm
	],
	[#Rule bin_op_199
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5533 ./PIR.pm
	],
	[#Rule bin_op_200
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5540 ./PIR.pm
	],
	[#Rule bin_op_201
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5547 ./PIR.pm
	],
	[#Rule bin_op_202
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5554 ./PIR.pm
	],
	[#Rule bin_op_203
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5561 ./PIR.pm
	],
	[#Rule bin_op_204
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5568 ./PIR.pm
	],
	[#Rule bin_op_205
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5575 ./PIR.pm
	],
	[#Rule bin_op_206
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5582 ./PIR.pm
	],
	[#Rule bin_op_207
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5589 ./PIR.pm
	],
	[#Rule bin_op_208
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5596 ./PIR.pm
	],
	[#Rule bin_op_209
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5603 ./PIR.pm
	],
	[#Rule bin_op_210
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5610 ./PIR.pm
	],
	[#Rule bin_op_211
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5617 ./PIR.pm
	],
	[#Rule bin_op_212
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5624 ./PIR.pm
	],
	[#Rule bin_op_213
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5631 ./PIR.pm
	],
	[#Rule bin_op_214
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5638 ./PIR.pm
	],
	[#Rule bin_op_215
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5645 ./PIR.pm
	],
	[#Rule bin_op_216
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5652 ./PIR.pm
	],
	[#Rule bin_op_217
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5659 ./PIR.pm
	],
	[#Rule bin_op_218
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5666 ./PIR.pm
	],
	[#Rule bin_op_219
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5673 ./PIR.pm
	],
	[#Rule bin_op_220
		 'bin_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5680 ./PIR.pm
	],
	[#Rule get_results_221
		 'get_results', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5687 ./PIR.pm
	],
	[#Rule op_assign_222
		 'op_assign', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5694 ./PIR.pm
	],
	[#Rule assign_op_223
		 'assign_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5701 ./PIR.pm
	],
	[#Rule assign_op_224
		 'assign_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5708 ./PIR.pm
	],
	[#Rule assign_op_225
		 'assign_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5715 ./PIR.pm
	],
	[#Rule assign_op_226
		 'assign_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5722 ./PIR.pm
	],
	[#Rule assign_op_227
		 'assign_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5729 ./PIR.pm
	],
	[#Rule assign_op_228
		 'assign_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5736 ./PIR.pm
	],
	[#Rule assign_op_229
		 'assign_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5743 ./PIR.pm
	],
	[#Rule assign_op_230
		 'assign_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5750 ./PIR.pm
	],
	[#Rule assign_op_231
		 'assign_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5757 ./PIR.pm
	],
	[#Rule assign_op_232
		 'assign_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5764 ./PIR.pm
	],
	[#Rule assign_op_233
		 'assign_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5771 ./PIR.pm
	],
	[#Rule assign_op_234
		 'assign_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5778 ./PIR.pm
	],
	[#Rule assign_op_235
		 'assign_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5785 ./PIR.pm
	],
	[#Rule func_assign_236
		 'func_assign', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5792 ./PIR.pm
	],
	[#Rule the_sub_237
		 'the_sub', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5799 ./PIR.pm
	],
	[#Rule the_sub_238
		 'the_sub', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5806 ./PIR.pm
	],
	[#Rule the_sub_239
		 'the_sub', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5813 ./PIR.pm
	],
	[#Rule the_sub_240
		 'the_sub', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5820 ./PIR.pm
	],
	[#Rule the_sub_241
		 'the_sub', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5827 ./PIR.pm
	],
	[#Rule the_sub_242
		 'the_sub', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5834 ./PIR.pm
	],
	[#Rule the_sub_243
		 'the_sub', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5841 ./PIR.pm
	],
	[#Rule the_sub_244
		 'the_sub', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5848 ./PIR.pm
	],
	[#Rule sub_call_245
		 'sub_call', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5855 ./PIR.pm
	],
	[#Rule arglist_246
		 'arglist', 0,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5862 ./PIR.pm
	],
	[#Rule arglist_247
		 'arglist', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5869 ./PIR.pm
	],
	[#Rule arglist_248
		 'arglist', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5876 ./PIR.pm
	],
	[#Rule arglist_249
		 'arglist', 5,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5883 ./PIR.pm
	],
	[#Rule arglist_250
		 'arglist', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5890 ./PIR.pm
	],
	[#Rule arglist_251
		 'arglist', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5897 ./PIR.pm
	],
	[#Rule arg_252
		 'arg', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5904 ./PIR.pm
	],
	[#Rule argtype_list_253
		 'argtype_list', 0,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5911 ./PIR.pm
	],
	[#Rule argtype_list_254
		 'argtype_list', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5918 ./PIR.pm
	],
	[#Rule argtype_255
		 'argtype', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5925 ./PIR.pm
	],
	[#Rule argtype_256
		 'argtype', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5932 ./PIR.pm
	],
	[#Rule argtype_257
		 'argtype', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5939 ./PIR.pm
	],
	[#Rule argtype_258
		 'argtype', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5946 ./PIR.pm
	],
	[#Rule argtype_259
		 'argtype', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5953 ./PIR.pm
	],
	[#Rule result_260
		 'result', 2,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5960 ./PIR.pm
	],
	[#Rule targetlist_261
		 'targetlist', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5967 ./PIR.pm
	],
	[#Rule targetlist_262
		 'targetlist', 5,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5974 ./PIR.pm
	],
	[#Rule targetlist_263
		 'targetlist', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5981 ./PIR.pm
	],
	[#Rule targetlist_264
		 'targetlist', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5988 ./PIR.pm
	],
	[#Rule targetlist_265
		 'targetlist', 0,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5995 ./PIR.pm
	],
	[#Rule conditional_statement_266
		 'conditional_statement', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6002 ./PIR.pm
	],
	[#Rule conditional_statement_267
		 'conditional_statement', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6009 ./PIR.pm
	],
	[#Rule unless_statement_268
		 'unless_statement', 6,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6016 ./PIR.pm
	],
	[#Rule unless_statement_269
		 'unless_statement', 5,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6023 ./PIR.pm
	],
	[#Rule unless_statement_270
		 'unless_statement', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6030 ./PIR.pm
	],
	[#Rule if_statement_271
		 'if_statement', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6037 ./PIR.pm
	],
	[#Rule if_statement_272
		 'if_statement', 6,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6044 ./PIR.pm
	],
	[#Rule if_statement_273
		 'if_statement', 5,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6051 ./PIR.pm
	],
	[#Rule comma_or_goto_274
		 'comma_or_goto', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6058 ./PIR.pm
	],
	[#Rule comma_or_goto_275
		 'comma_or_goto', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6065 ./PIR.pm
	],
	[#Rule relop_276
		 'relop', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6072 ./PIR.pm
	],
	[#Rule relop_277
		 'relop', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6079 ./PIR.pm
	],
	[#Rule relop_278
		 'relop', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6086 ./PIR.pm
	],
	[#Rule relop_279
		 'relop', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6093 ./PIR.pm
	],
	[#Rule relop_280
		 'relop', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6100 ./PIR.pm
	],
	[#Rule relop_281
		 'relop', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6107 ./PIR.pm
	],
	[#Rule target_282
		 'target', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6114 ./PIR.pm
	],
	[#Rule target_283
		 'target', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6121 ./PIR.pm
	],
	[#Rule vars_284
		 'vars', 0,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6128 ./PIR.pm
	],
	[#Rule vars_285
		 'vars', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6135 ./PIR.pm
	],
	[#Rule _vars_286
		 '_vars', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6142 ./PIR.pm
	],
	[#Rule _vars_287
		 '_vars', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6149 ./PIR.pm
	],
	[#Rule _var_or_i_288
		 '_var_or_i', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6156 ./PIR.pm
	],
	[#Rule _var_or_i_289
		 '_var_or_i', 4,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6163 ./PIR.pm
	],
	[#Rule _var_or_i_290
		 '_var_or_i', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6170 ./PIR.pm
	],
	[#Rule sub_label_op_c_291
		 'sub_label_op_c', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6177 ./PIR.pm
	],
	[#Rule sub_label_op_c_292
		 'sub_label_op_c', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6184 ./PIR.pm
	],
	[#Rule sub_label_op_c_293
		 'sub_label_op_c', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6191 ./PIR.pm
	],
	[#Rule sub_label_op_294
		 'sub_label_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6198 ./PIR.pm
	],
	[#Rule sub_label_op_295
		 'sub_label_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6205 ./PIR.pm
	],
	[#Rule label_op_296
		 'label_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6212 ./PIR.pm
	],
	[#Rule label_op_297
		 'label_op', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6219 ./PIR.pm
	],
	[#Rule var_or_i_298
		 'var_or_i', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6226 ./PIR.pm
	],
	[#Rule var_or_i_299
		 'var_or_i', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6233 ./PIR.pm
	],
	[#Rule var_300
		 'var', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6240 ./PIR.pm
	],
	[#Rule var_301
		 'var', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6247 ./PIR.pm
	],
	[#Rule keylist_302
		 'keylist', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6254 ./PIR.pm
	],
	[#Rule keylist_force_303
		 'keylist_force', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6261 ./PIR.pm
	],
	[#Rule _keylist_304
		 '_keylist', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6268 ./PIR.pm
	],
	[#Rule _keylist_305
		 '_keylist', 3,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6275 ./PIR.pm
	],
	[#Rule key_306
		 'key', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6282 ./PIR.pm
	],
	[#Rule reg_307
		 'reg', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6289 ./PIR.pm
	],
	[#Rule reg_308
		 'reg', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6296 ./PIR.pm
	],
	[#Rule reg_309
		 'reg', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6303 ./PIR.pm
	],
	[#Rule reg_310
		 'reg', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6310 ./PIR.pm
	],
	[#Rule reg_311
		 'reg', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6317 ./PIR.pm
	],
	[#Rule const_312
		 'const', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6324 ./PIR.pm
	],
	[#Rule const_313
		 'const', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6331 ./PIR.pm
	],
	[#Rule const_314
		 'const', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6338 ./PIR.pm
	],
	[#Rule const_315
		 'const', 1,
sub {
#line 115 "PIR.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6345 ./PIR.pm
	]
],
#line 6348 ./PIR.pm
    yybypass       => 0,
    yybuildingtree => 1,
    yyprefix       => '',
    yyaccessors    => {
   },
    @_,
  );
  bless($self,$class);

  $self->make_node_classes('TERMINAL', '_OPTIONAL', '_STAR_LIST', '_PLUS_LIST', 
         '_SUPERSTART', 
         'program_1', 
         'compilation_units_2', 
         'compilation_units_3', 
         'compilation_unit_4', 
         'compilation_unit_5', 
         'compilation_unit_6', 
         'compilation_unit_7', 
         'compilation_unit_8', 
         'compilation_unit_9', 
         'compilation_unit_10', 
         'compilation_unit_11', 
         'pragma_12', 
         'pragma_13', 
         'location_directive_14', 
         'location_directive_15', 
         'annotate_directive_16', 
         'hll_def_17', 
         'constdef_18', 
         'pmc_const_19', 
         'pmc_const_20', 
         'any_string_21', 
         'any_string_22', 
         'pasmcode_23', 
         'pasmcode_24', 
         'pasmline_25', 
         'pasmline_26', 
         'pasmline_27', 
         'pasmline_28', 
         'pasmline_29', 
         'pasmline_30', 
         'pasmline_31', 
         'pasm_inst_32', 
         'pasm_inst_33', 
         'pasm_inst_34', 
         'pasm_inst_35', 
         'pasm_inst_36', 
         'pasm_args_37', 
         'emit_38', 
         'opt_pasmcode_39', 
         'opt_pasmcode_40', 
         'class_namespace_41', 
         'maybe_ns_42', 
         'maybe_ns_43', 
         'sub_44', 
         'sub_params_45', 
         'sub_params_46', 
         'sub_params_47', 
         'sub_param_48', 
         'sub_param_type_def_49', 
         'multi_50', 
         'outer_51', 
         'outer_52', 
         'vtable_53', 
         'vtable_54', 
         'method_55', 
         'method_56', 
         'ns_entry_name_57', 
         'ns_entry_name_58', 
         'instanceof_59', 
         'subid_60', 
         'subid_61', 
         'multi_types_62', 
         'multi_types_63', 
         'multi_types_64', 
         'multi_type_65', 
         'multi_type_66', 
         'multi_type_67', 
         'multi_type_68', 
         'multi_type_69', 
         'multi_type_70', 
         'multi_type_71', 
         'sub_body_72', 
         'sub_body_73', 
         'pcc_sub_call_74', 
         'opt_label_75', 
         'opt_label_76', 
         'opt_invocant_77', 
         'opt_invocant_78', 
         'sub_proto_79', 
         'sub_proto_80', 
         'sub_proto_list_81', 
         'sub_proto_list_82', 
         'proto_83', 
         'proto_84', 
         'proto_85', 
         'proto_86', 
         'proto_87', 
         'proto_88', 
         'proto_89', 
         'proto_90', 
         'proto_91', 
         'proto_92', 
         'proto_93', 
         'proto_94', 
         'proto_95', 
         'proto_96', 
         'pcc_call_97', 
         'pcc_call_98', 
         'pcc_call_99', 
         'pcc_call_100', 
         'pcc_call_101', 
         'pcc_call_102', 
         'pcc_call_103', 
         'pcc_args_104', 
         'pcc_args_105', 
         'pcc_arg_106', 
         'pcc_results_107', 
         'pcc_results_108', 
         'pcc_result_109', 
         'pcc_result_110', 
         'paramtype_list_111', 
         'paramtype_list_112', 
         'paramtype_113', 
         'paramtype_114', 
         'paramtype_115', 
         'paramtype_116', 
         'paramtype_117', 
         'paramtype_118', 
         'paramtype_119', 
         'paramtype_120', 
         'pcc_ret_121', 
         'pcc_ret_122', 
         'pcc_yield_123', 
         'pcc_returns_124', 
         'pcc_returns_125', 
         'pcc_returns_126', 
         'pcc_yields_127', 
         'pcc_yields_128', 
         'pcc_yields_129', 
         'pcc_return_130', 
         'pcc_set_yield_131', 
         'pcc_return_many_132', 
         'return_or_yield_133', 
         'return_or_yield_134', 
         'var_returns_135', 
         'var_returns_136', 
         'var_returns_137', 
         'var_returns_138', 
         'var_returns_139', 
         'statements_140', 
         'statements_141', 
         'helper_clear_state_142', 
         'statement_143', 
         'statement_144', 
         'statement_145', 
         'statement_146', 
         'statement_147', 
         'statement_148', 
         'labels_149', 
         'labels_150', 
         '_labels_151', 
         '_labels_152', 
         'label_153', 
         'instruction_154', 
         'instruction_155', 
         'id_list_156', 
         'id_list_157', 
         'id_list_id_158', 
         'opt_unique_reg_159', 
         'opt_unique_reg_160', 
         'labeled_inst_161', 
         'labeled_inst_162', 
         'labeled_inst_163', 
         'labeled_inst_164', 
         'labeled_inst_165', 
         'labeled_inst_166', 
         'labeled_inst_167', 
         'labeled_inst_168', 
         'labeled_inst_169', 
         'labeled_inst_170', 
         'labeled_inst_171', 
         'labeled_inst_172', 
         'labeled_inst_173', 
         'labeled_inst_174', 
         'labeled_inst_175', 
         'labeled_inst_176', 
         'labeled_inst_177', 
         'type_178', 
         'type_179', 
         'type_180', 
         'type_181', 
         'classname_182', 
         'assignment_183', 
         'assignment_184', 
         'assignment_185', 
         'assignment_186', 
         'assignment_187', 
         'assignment_188', 
         'assignment_189', 
         'assignment_190', 
         'assignment_191', 
         'assignment_192', 
         'assignment_193', 
         'assignment_194', 
         'un_op_195', 
         'un_op_196', 
         'un_op_197', 
         'bin_op_198', 
         'bin_op_199', 
         'bin_op_200', 
         'bin_op_201', 
         'bin_op_202', 
         'bin_op_203', 
         'bin_op_204', 
         'bin_op_205', 
         'bin_op_206', 
         'bin_op_207', 
         'bin_op_208', 
         'bin_op_209', 
         'bin_op_210', 
         'bin_op_211', 
         'bin_op_212', 
         'bin_op_213', 
         'bin_op_214', 
         'bin_op_215', 
         'bin_op_216', 
         'bin_op_217', 
         'bin_op_218', 
         'bin_op_219', 
         'bin_op_220', 
         'get_results_221', 
         'op_assign_222', 
         'assign_op_223', 
         'assign_op_224', 
         'assign_op_225', 
         'assign_op_226', 
         'assign_op_227', 
         'assign_op_228', 
         'assign_op_229', 
         'assign_op_230', 
         'assign_op_231', 
         'assign_op_232', 
         'assign_op_233', 
         'assign_op_234', 
         'assign_op_235', 
         'func_assign_236', 
         'the_sub_237', 
         'the_sub_238', 
         'the_sub_239', 
         'the_sub_240', 
         'the_sub_241', 
         'the_sub_242', 
         'the_sub_243', 
         'the_sub_244', 
         'sub_call_245', 
         'arglist_246', 
         'arglist_247', 
         'arglist_248', 
         'arglist_249', 
         'arglist_250', 
         'arglist_251', 
         'arg_252', 
         'argtype_list_253', 
         'argtype_list_254', 
         'argtype_255', 
         'argtype_256', 
         'argtype_257', 
         'argtype_258', 
         'argtype_259', 
         'result_260', 
         'targetlist_261', 
         'targetlist_262', 
         'targetlist_263', 
         'targetlist_264', 
         'targetlist_265', 
         'conditional_statement_266', 
         'conditional_statement_267', 
         'unless_statement_268', 
         'unless_statement_269', 
         'unless_statement_270', 
         'if_statement_271', 
         'if_statement_272', 
         'if_statement_273', 
         'comma_or_goto_274', 
         'comma_or_goto_275', 
         'relop_276', 
         'relop_277', 
         'relop_278', 
         'relop_279', 
         'relop_280', 
         'relop_281', 
         'target_282', 
         'target_283', 
         'vars_284', 
         'vars_285', 
         '_vars_286', 
         '_vars_287', 
         '_var_or_i_288', 
         '_var_or_i_289', 
         '_var_or_i_290', 
         'sub_label_op_c_291', 
         'sub_label_op_c_292', 
         'sub_label_op_c_293', 
         'sub_label_op_294', 
         'sub_label_op_295', 
         'label_op_296', 
         'label_op_297', 
         'var_or_i_298', 
         'var_or_i_299', 
         'var_300', 
         'var_301', 
         'keylist_302', 
         'keylist_force_303', 
         '_keylist_304', 
         '_keylist_305', 
         'key_306', 
         'reg_307', 
         'reg_308', 
         'reg_309', 
         'reg_310', 
         'reg_311', 
         'const_312', 
         'const_313', 
         'const_314', 
         'const_315', );
  $self;
}

#line 762 "PIR.eyp"


my %directives = (
".set_arg"               => 'ARG',
".sub"                   => 'SUB',
".end"                   => 'ESUB',
".begin_call"            => 'PCC_BEGIN',
".end_call"              => 'PCC_END',
".call"                  => 'PCC_CALL',
".nci_call"              => 'NCI_CALL',
".meth_call"             => 'METH_CALL',
".invocant"              => 'INVOCANT',
".begin_return"          => 'PCC_BEGIN_RETURN',
".end_return"            => 'PCC_END_RETURN',
".begin_yield"           => 'PCC_BEGIN_YIELD',
".end_yield"             => 'PCC_END_YIELD',

".get_result"                  => 'RESULT',
".get_results"             => 'GET_RESULTS',
".yield"                   => 'YIELDT',
".set_yield"               => 'SET_YIELD',
".return"                  => 'RETURN',
".set_return"              => 'SET_RETURN',
".tailcall"                => 'TAILCALL',

".local"                      => 'LOCAL',
".globalconst"                => 'GLOBAL_CONST',
".param"                      => 'PARAM',
);

my %colons = (
":unique_reg"   => 'UNIQUE_REG',
":instanceof"   => 'SUB_INSTANCE_OF',
":subid"        => 'SUBID',
":flat"         => 'ADV_FLAT',
":slurpy"       => 'ADV_SLURPY',
":optional"     => 'ADV_OPTIONAL',
":opt_flag"     => 'ADV_OPT_FLAG',
":named"        => 'ADV_NAMED',
":invocant"     => 'ADV_INVOCANT',
":call_sig"     => 'ADV_CALL_SIG',
);

my %words = (
"goto"                        => 'GOTO',
"if"                          => 'IF',
"unless"                      => 'UNLESS',
"null"                        => 'PNULL',
"int"                         => 'INTV',
"num"                         => 'FLOATV',

"pmc"                         => 'PMCV',
"string"                      => 'STRINGV',
);

my %lexemes = (
"=>"                   => 'ADV_ARROW',
"<<"                   => 'SHIFT_LEFT',
">>"                   => 'SHIFT_RIGHT',
">>>"                  => 'SHIFT_RIGHT_U',
"&&"                   => 'LOG_AND',
"||"                   => 'LOG_OR',
"~~"                   => 'LOG_XOR',
"<"                    => 'RELOP_LT',
"<="                   => 'RELOP_LTE',
">"                    => 'RELOP_GT',
">="                   => 'RELOP_GTE',
"=="                   => 'RELOP_EQ',
"!="                   => 'RELOP_NE',
"**"                   => 'POW',

"."                    => 'DOT',

"+="                   => 'PLUS_ASSIGN',
"-="                   => 'MINUS_ASSIGN',
"*="                   => 'MUL_ASSIGN',
"/="                   => 'DIV_ASSIGN',
"%="                   => 'MOD_ASSIGN',
"//"                   => 'FDIV',
"//="                  => 'FDIV_ASSIGN',
"&="                   => 'BAND_ASSIGN',
"|="                   => 'BOR_ASSIGN',
"~="                   => 'BXOR_ASSIGN',
">>="                  => 'SHR_ASSIGN',
"<<="                  => 'SHL_ASSIGN',
">>>="                 => 'SHR_U_ASSIGN',
".="                   => 'CONCAT_ASSIGN',
);



=for None

=cut



#line 6776 ./PIR.pm

1;
