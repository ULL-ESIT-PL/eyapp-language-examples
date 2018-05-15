#!/usr/bin/perl
########################################################################################
#
#    This file was generated using Parse::Eyapp version 1.182.
#
# (c) Parse::Yapp Copyright 1998-2001 Francois Desarmenien.
# (c) Parse::Eyapp Copyright 2006-2008 Casiano Rodriguez-Leon. Universidad de La Laguna.
#        Don't edit this file, use source file 'pascal.eyp' instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
########################################################################################
package pascal;
use strict;

push @pascal::ISA, 'Parse::Eyapp::Driver';




BEGIN {
  # This strange way to load the modules is to guarantee compatibility when
  # using several standalone and non-standalone Eyapp parsers

  require Parse::Eyapp::Driver unless Parse::Eyapp::Driver->can('YYParse');
  require Parse::Eyapp::Node unless Parse::Eyapp::Node->can('hnew'); 
}
  

sub unexpendedInput { defined($_) ? substr($_, (defined(pos $_) ? pos $_ : 0)) : '' }

#line 1 "pascal.eyp"


#  pascal.eyp
# 
#  Pascal grammar in Eyapp format, based originally on BNF given
#  in "Standard Pascal -- User Reference Manual", by Doug Cooper.
#  This in turn is the BNF given by the ANSI and ISO Pascal standards,
#  and so, is PUBLIC DOMAIN. The grammar is for ISO Level 0 Pascal.
#  The grammar has been massaged somewhat to make it LALR, and added
#  the following extensions.
# 
#  constant expressions
#  otherwise statement in a case
#  productions to correctly match else's with if's
#  beginnings of a separate compilation facility
# 



# Default lexical analyzer
our $LEX = sub {
    my $self = shift;
    my $pos;

    for (${$self->input}) {
      

      m{\G(\s+)}gc and $self->tokenline($1 =~ tr{\n}{});

      

      /\G(CASE)/gc and return ($1, $1);
      /\G(DIGSEQ)/gc and return ($1, $1);
      /\G(ARRAY)/gc and return ($1, $1);
      /\G(ASSIGNMENT)/gc and return ($1, $1);
      /\G(COLON)/gc and return ($1, $1);
      /\G(COMMA)/gc and return ($1, $1);
      /\G(AND)/gc and return ($1, $1);
      /\G(CHARACTER_STRING)/gc and return ($1, $1);
      /\G(CONST)/gc and return ($1, $1);
      /\G(DOWNTO)/gc and return ($1, $1);
      /\G(FORWARD)/gc and return ($1, $1);
      /\G(DIV)/gc and return ($1, $1);
      /\G(EXTERNAL)/gc and return ($1, $1);
      /\G(DOT)/gc and return ($1, $1);
      /\G(FOR)/gc and return ($1, $1);
      /\G(FUNCTION)/gc and return ($1, $1);
      /\G(DO)/gc and return ($1, $1);
      /\G(END)/gc and return ($1, $1);
      /\G(DOTDOT)/gc and return ($1, $1);
      /\G(EQUAL)/gc and return ($1, $1);
      /\G(ELSE)/gc and return ($1, $1);
      /\G(LPAREN)/gc and return ($1, $1);
      /\G(LE)/gc and return ($1, $1);
      /\G(GOTO)/gc and return ($1, $1);
      /\G(MOD)/gc and return ($1, $1);
      /\G(GE)/gc and return ($1, $1);
      /\G(IN)/gc and return ($1, $1);
      /\G(MINUS)/gc and return ($1, $1);
      /\G(LBRAC)/gc and return ($1, $1);
      /\G(LT)/gc and return ($1, $1);
      /\G(IF)/gc and return ($1, $1);
      /\G(NOT)/gc and return ($1, $1);
      /\G(NIL)/gc and return ($1, $1);
      /\G(LABEL)/gc and return ($1, $1);
      /\G(GT)/gc and return ($1, $1);
      /\G(IDENTIFIER)/gc and return ($1, $1);
      /\G(RBRAC)/gc and return ($1, $1);
      /\G(PACKED)/gc and return ($1, $1);
      /\G(OTHERWISE)/gc and return ($1, $1);
      /\G(NOTEQUAL)/gc and return ($1, $1);
      /\G(OF)/gc and return ($1, $1);
      /\G(PROCEDURE)/gc and return ($1, $1);
      /\G(PLUS)/gc and return ($1, $1);
      /\G(PBEGIN)/gc and return ($1, $1);
      /\G(PROGRAM)/gc and return ($1, $1);
      /\G(OR)/gc and return ($1, $1);
      /\G(PFILE)/gc and return ($1, $1);
      /\G(THEN)/gc and return ($1, $1);
      /\G(SLASH)/gc and return ($1, $1);
      /\G(RPAREN)/gc and return ($1, $1);
      /\G(STARSTAR)/gc and return ($1, $1);
      /\G(SEMICOLON)/gc and return ($1, $1);
      /\G(RECORD)/gc and return ($1, $1);
      /\G(REPEAT)/gc and return ($1, $1);
      /\G(REALNUMBER)/gc and return ($1, $1);
      /\G(SET)/gc and return ($1, $1);
      /\G(STAR)/gc and return ($1, $1);
      /\G(TO)/gc and return ($1, $1);
      /\G(WHILE)/gc and return ($1, $1);
      /\G(TYPE)/gc and return ($1, $1);
      /\G(WITH)/gc and return ($1, $1);
      /\G(UNTIL)/gc and return ($1, $1);
      /\G(VAR)/gc and return ($1, $1);
      /\G(UPARROW)/gc and return ($1, $1);


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


#line 143 ./pascal.pm

my $warnmessage =<< "EOFWARN";
Warning!: Did you changed the \@pascal::ISA variable inside the header section of the eyapp program?
EOFWARN

sub new {
  my($class)=shift;
  ref($class) and $class=ref($class);

  warn $warnmessage unless __PACKAGE__->isa('Parse::Eyapp::Driver'); 
  my($self)=$class->SUPER::new( 
    yyversion => '1.182',
    yyGRAMMAR  =>
[#[productionNameAndLabel => lhs, [ rhs], bypass]]
  [ '_SUPERSTART' => '$start', [ 'file', '$end' ], 0 ],
  [ 'file_is_program' => 'file', [ 'program' ], 0 ],
  [ 'file_is_module' => 'file', [ 'module' ], 0 ],
  [ 'program_is_programHeading_semicolon_block_DOT' => 'program', [ 'program_heading', 'semicolon', 'block', 'DOT' ], 0 ],
  [ 'programHeading_is_PROGRAM_identifier' => 'program_heading', [ 'PROGRAM', 'identifier' ], 0 ],
  [ 'programHeading_is_PROGRAM_identifier_LPAREN_identifierList_RPAREN' => 'program_heading', [ 'PROGRAM', 'identifier', 'LPAREN', 'identifier_list', 'RPAREN' ], 0 ],
  [ 'identifierList_is_identifierList_comma_identifier' => 'identifier_list', [ 'identifier_list', 'comma', 'identifier' ], 0 ],
  [ 'identifierList_is_identifier' => 'identifier_list', [ 'identifier' ], 0 ],
  [ 'block_is_labelDeclarationPart_constantDefinitionPart_typeDefinitionPart_variableDeclarationPart_procedureAndFunctionDeclarationPart_statementPart' => 'block', [ 'label_declaration_part', 'constant_definition_part', 'type_definition_part', 'variable_declaration_part', 'procedure_and_function_declaration_part', 'statement_part' ], 0 ],
  [ 'module_is_constantDefinitionPart_typeDefinitionPart_variableDeclarationPart_procedureAndFunctionDeclarationPart' => 'module', [ 'constant_definition_part', 'type_definition_part', 'variable_declaration_part', 'procedure_and_function_declaration_part' ], 0 ],
  [ 'labelDeclarationPart_is_LABEL_labelList_semicolon' => 'label_declaration_part', [ 'LABEL', 'label_list', 'semicolon' ], 0 ],
  [ 'labelDeclarationPart_is_empty' => 'label_declaration_part', [  ], 0 ],
  [ 'labelList_is_labelList_comma_label' => 'label_list', [ 'label_list', 'comma', 'label' ], 0 ],
  [ 'labelList_is_label' => 'label_list', [ 'label' ], 0 ],
  [ 'label_is_DIGSEQ' => 'label', [ 'DIGSEQ' ], 0 ],
  [ 'constantDefinitionPart_is_CONST_constantList' => 'constant_definition_part', [ 'CONST', 'constant_list' ], 0 ],
  [ 'constantDefinitionPart_is_empty' => 'constant_definition_part', [  ], 0 ],
  [ 'constantList_is_constantList_constantDefinition' => 'constant_list', [ 'constant_list', 'constant_definition' ], 0 ],
  [ 'constantList_is_constantDefinition' => 'constant_list', [ 'constant_definition' ], 0 ],
  [ 'constantDefinition_is_identifier_EQUAL_cexpression_semicolon' => 'constant_definition', [ 'identifier', 'EQUAL', 'cexpression', 'semicolon' ], 0 ],
  [ 'cexpression_is_csimpleExpression' => 'cexpression', [ 'csimple_expression' ], 0 ],
  [ 'cexpression_is_csimpleExpression_relop_csimpleExpression' => 'cexpression', [ 'csimple_expression', 'relop', 'csimple_expression' ], 0 ],
  [ 'csimpleExpression_is_cterm' => 'csimple_expression', [ 'cterm' ], 0 ],
  [ 'csimpleExpression_is_csimpleExpression_addop_cterm' => 'csimple_expression', [ 'csimple_expression', 'addop', 'cterm' ], 0 ],
  [ 'cterm_is_cfactor' => 'cterm', [ 'cfactor' ], 0 ],
  [ 'cterm_is_cterm_mulop_cfactor' => 'cterm', [ 'cterm', 'mulop', 'cfactor' ], 0 ],
  [ 'cfactor_is_sign_cfactor' => 'cfactor', [ 'sign', 'cfactor' ], 0 ],
  [ 'cfactor_is_cexponentiation' => 'cfactor', [ 'cexponentiation' ], 0 ],
  [ 'cexponentiation_is_cprimary' => 'cexponentiation', [ 'cprimary' ], 0 ],
  [ 'cexponentiation_is_cprimary_STARSTAR_cexponentiation' => 'cexponentiation', [ 'cprimary', 'STARSTAR', 'cexponentiation' ], 0 ],
  [ 'cprimary_is_identifier' => 'cprimary', [ 'identifier' ], 0 ],
  [ 'cprimary_is_LPAREN_cexpression_RPAREN' => 'cprimary', [ 'LPAREN', 'cexpression', 'RPAREN' ], 0 ],
  [ 'cprimary_is_unsignedConstant' => 'cprimary', [ 'unsigned_constant' ], 0 ],
  [ 'cprimary_is_NOT_cprimary' => 'cprimary', [ 'NOT', 'cprimary' ], 0 ],
  [ 'constant_is_nonString' => 'constant', [ 'non_string' ], 0 ],
  [ 'constant_is_sign_nonString' => 'constant', [ 'sign', 'non_string' ], 0 ],
  [ 'constant_is_CHARACTER_STRING' => 'constant', [ 'CHARACTER_STRING' ], 0 ],
  [ 'sign_is_PLUS' => 'sign', [ 'PLUS' ], 0 ],
  [ 'sign_is_MINUS' => 'sign', [ 'MINUS' ], 0 ],
  [ 'nonString_is_DIGSEQ' => 'non_string', [ 'DIGSEQ' ], 0 ],
  [ 'nonString_is_identifier' => 'non_string', [ 'identifier' ], 0 ],
  [ 'nonString_is_REALNUMBER' => 'non_string', [ 'REALNUMBER' ], 0 ],
  [ 'typeDefinitionPart_is_TYPE_typeDefinitionList' => 'type_definition_part', [ 'TYPE', 'type_definition_list' ], 0 ],
  [ 'typeDefinitionPart_is_empty' => 'type_definition_part', [  ], 0 ],
  [ 'typeDefinitionList_is_typeDefinitionList_typeDefinition' => 'type_definition_list', [ 'type_definition_list', 'type_definition' ], 0 ],
  [ 'typeDefinitionList_is_typeDefinition' => 'type_definition_list', [ 'type_definition' ], 0 ],
  [ 'typeDefinition_is_identifier_EQUAL_typeDenoter_semicolon' => 'type_definition', [ 'identifier', 'EQUAL', 'type_denoter', 'semicolon' ], 0 ],
  [ 'typeDenoter_is_identifier' => 'type_denoter', [ 'identifier' ], 0 ],
  [ 'typeDenoter_is_newType' => 'type_denoter', [ 'new_type' ], 0 ],
  [ 'newType_is_newOrdinalType' => 'new_type', [ 'new_ordinal_type' ], 0 ],
  [ 'newType_is_newStructuredType' => 'new_type', [ 'new_structured_type' ], 0 ],
  [ 'newType_is_newPointerType' => 'new_type', [ 'new_pointer_type' ], 0 ],
  [ 'newOrdinalType_is_enumeratedType' => 'new_ordinal_type', [ 'enumerated_type' ], 0 ],
  [ 'newOrdinalType_is_subrangeType' => 'new_ordinal_type', [ 'subrange_type' ], 0 ],
  [ 'enumeratedType_is_LPAREN_identifierList_RPAREN' => 'enumerated_type', [ 'LPAREN', 'identifier_list', 'RPAREN' ], 0 ],
  [ 'subrangeType_is_constant_DOTDOT_constant' => 'subrange_type', [ 'constant', 'DOTDOT', 'constant' ], 0 ],
  [ 'newStructuredType_is_structuredType' => 'new_structured_type', [ 'structured_type' ], 0 ],
  [ 'newStructuredType_is_PACKED_structuredType' => 'new_structured_type', [ 'PACKED', 'structured_type' ], 0 ],
  [ 'structuredType_is_arrayType' => 'structured_type', [ 'array_type' ], 0 ],
  [ 'structuredType_is_recordType' => 'structured_type', [ 'record_type' ], 0 ],
  [ 'structuredType_is_setType' => 'structured_type', [ 'set_type' ], 0 ],
  [ 'structuredType_is_fileType' => 'structured_type', [ 'file_type' ], 0 ],
  [ 'arrayType_is_ARRAY_LBRAC_indexList_RBRAC_OF_componentType' => 'array_type', [ 'ARRAY', 'LBRAC', 'index_list', 'RBRAC', 'OF', 'component_type' ], 0 ],
  [ 'indexList_is_indexList_comma_indexType' => 'index_list', [ 'index_list', 'comma', 'index_type' ], 0 ],
  [ 'indexList_is_indexType' => 'index_list', [ 'index_type' ], 0 ],
  [ 'indexType_is_ordinalType' => 'index_type', [ 'ordinal_type' ], 0 ],
  [ 'ordinalType_is_newOrdinalType' => 'ordinal_type', [ 'new_ordinal_type' ], 0 ],
  [ 'ordinalType_is_identifier' => 'ordinal_type', [ 'identifier' ], 0 ],
  [ 'componentType_is_typeDenoter' => 'component_type', [ 'type_denoter' ], 0 ],
  [ 'recordType_is_RECORD_recordSectionList_END' => 'record_type', [ 'RECORD', 'record_section_list', 'END' ], 0 ],
  [ 'recordType_is_RECORD_recordSectionList_semicolon_variantPart_END' => 'record_type', [ 'RECORD', 'record_section_list', 'semicolon', 'variant_part', 'END' ], 0 ],
  [ 'recordType_is_RECORD_variantPart_END' => 'record_type', [ 'RECORD', 'variant_part', 'END' ], 0 ],
  [ 'recordSectionList_is_recordSectionList_semicolon_recordSection' => 'record_section_list', [ 'record_section_list', 'semicolon', 'record_section' ], 0 ],
  [ 'recordSectionList_is_recordSection' => 'record_section_list', [ 'record_section' ], 0 ],
  [ 'recordSection_is_identifierList_COLON_typeDenoter' => 'record_section', [ 'identifier_list', 'COLON', 'type_denoter' ], 0 ],
  [ 'variantPart_is_CASE_variantSelector_OF_variantList_semicolon' => 'variant_part', [ 'CASE', 'variant_selector', 'OF', 'variant_list', 'semicolon' ], 0 ],
  [ 'variantPart_is_CASE_variantSelector_OF_variantList' => 'variant_part', [ 'CASE', 'variant_selector', 'OF', 'variant_list' ], 0 ],
  [ 'variantPart_is_empty' => 'variant_part', [  ], 0 ],
  [ 'variantSelector_is_tagField_COLON_tagType' => 'variant_selector', [ 'tag_field', 'COLON', 'tag_type' ], 0 ],
  [ 'variantSelector_is_tagType' => 'variant_selector', [ 'tag_type' ], 0 ],
  [ 'variantList_is_variantList_semicolon_variant' => 'variant_list', [ 'variant_list', 'semicolon', 'variant' ], 0 ],
  [ 'variantList_is_variant' => 'variant_list', [ 'variant' ], 0 ],
  [ 'variant_is_caseConstantList_COLON_LPAREN_recordSectionList_RPAREN' => 'variant', [ 'case_constant_list', 'COLON', 'LPAREN', 'record_section_list', 'RPAREN' ], 0 ],
  [ 'variant_is_caseConstantList_COLON_LPAREN_recordSectionList_semicolon_variantPart_RPAREN' => 'variant', [ 'case_constant_list', 'COLON', 'LPAREN', 'record_section_list', 'semicolon', 'variant_part', 'RPAREN' ], 0 ],
  [ 'variant_is_caseConstantList_COLON_LPAREN_variantPart_RPAREN' => 'variant', [ 'case_constant_list', 'COLON', 'LPAREN', 'variant_part', 'RPAREN' ], 0 ],
  [ 'caseConstantList_is_caseConstantList_comma_caseConstant' => 'case_constant_list', [ 'case_constant_list', 'comma', 'case_constant' ], 0 ],
  [ 'caseConstantList_is_caseConstant' => 'case_constant_list', [ 'case_constant' ], 0 ],
  [ 'caseConstant_is_constant' => 'case_constant', [ 'constant' ], 0 ],
  [ 'caseConstant_is_constant_DOTDOT_constant' => 'case_constant', [ 'constant', 'DOTDOT', 'constant' ], 0 ],
  [ 'tagField_is_identifier' => 'tag_field', [ 'identifier' ], 0 ],
  [ 'tagType_is_identifier' => 'tag_type', [ 'identifier' ], 0 ],
  [ 'setType_is_SET_OF_baseType' => 'set_type', [ 'SET', 'OF', 'base_type' ], 0 ],
  [ 'baseType_is_ordinalType' => 'base_type', [ 'ordinal_type' ], 0 ],
  [ 'fileType_is_PFILE_OF_componentType' => 'file_type', [ 'PFILE', 'OF', 'component_type' ], 0 ],
  [ 'newPointerType_is_UPARROW_domainType' => 'new_pointer_type', [ 'UPARROW', 'domain_type' ], 0 ],
  [ 'domainType_is_identifier' => 'domain_type', [ 'identifier' ], 0 ],
  [ 'variableDeclarationPart_is_VAR_variableDeclarationList_semicolon' => 'variable_declaration_part', [ 'VAR', 'variable_declaration_list', 'semicolon' ], 0 ],
  [ 'variableDeclarationPart_is_empty' => 'variable_declaration_part', [  ], 0 ],
  [ 'variableDeclarationList_is_variableDeclarationList_semicolon_variableDeclaration' => 'variable_declaration_list', [ 'variable_declaration_list', 'semicolon', 'variable_declaration' ], 0 ],
  [ 'variableDeclarationList_is_variableDeclaration' => 'variable_declaration_list', [ 'variable_declaration' ], 0 ],
  [ 'variableDeclaration_is_identifierList_COLON_typeDenoter' => 'variable_declaration', [ 'identifier_list', 'COLON', 'type_denoter' ], 0 ],
  [ 'procedureAndFunctionDeclarationPart_is_procOrFuncDeclarationList_semicolon' => 'procedure_and_function_declaration_part', [ 'proc_or_func_declaration_list', 'semicolon' ], 0 ],
  [ 'procedureAndFunctionDeclarationPart_is_empty' => 'procedure_and_function_declaration_part', [  ], 0 ],
  [ 'procOrFuncDeclarationList_is_procOrFuncDeclarationList_semicolon_procOrFuncDeclaration' => 'proc_or_func_declaration_list', [ 'proc_or_func_declaration_list', 'semicolon', 'proc_or_func_declaration' ], 0 ],
  [ 'procOrFuncDeclarationList_is_procOrFuncDeclaration' => 'proc_or_func_declaration_list', [ 'proc_or_func_declaration' ], 0 ],
  [ 'procOrFuncDeclaration_is_procedureDeclaration' => 'proc_or_func_declaration', [ 'procedure_declaration' ], 0 ],
  [ 'procOrFuncDeclaration_is_functionDeclaration' => 'proc_or_func_declaration', [ 'function_declaration' ], 0 ],
  [ 'procedureDeclaration_is_procedureHeading_semicolon_directive' => 'procedure_declaration', [ 'procedure_heading', 'semicolon', 'directive' ], 0 ],
  [ 'procedureDeclaration_is_procedureHeading_semicolon_procedureBlock' => 'procedure_declaration', [ 'procedure_heading', 'semicolon', 'procedure_block' ], 0 ],
  [ 'procedureHeading_is_procedureIdentification' => 'procedure_heading', [ 'procedure_identification' ], 0 ],
  [ 'procedureHeading_is_procedureIdentification_formalParameterList' => 'procedure_heading', [ 'procedure_identification', 'formal_parameter_list' ], 0 ],
  [ 'directive_is_FORWARD' => 'directive', [ 'FORWARD' ], 0 ],
  [ 'directive_is_EXTERNAL' => 'directive', [ 'EXTERNAL' ], 0 ],
  [ 'formalParameterList_is_LPAREN_formalParameterSectionList_RPAREN' => 'formal_parameter_list', [ 'LPAREN', 'formal_parameter_section_list', 'RPAREN' ], 0 ],
  [ 'formalParameterSectionList_is_formalParameterSectionList_semicolon_formalParameterSection' => 'formal_parameter_section_list', [ 'formal_parameter_section_list', 'semicolon', 'formal_parameter_section' ], 0 ],
  [ 'formalParameterSectionList_is_formalParameterSection' => 'formal_parameter_section_list', [ 'formal_parameter_section' ], 0 ],
  [ 'formalParameterSection_is_valueParameterSpecification' => 'formal_parameter_section', [ 'value_parameter_specification' ], 0 ],
  [ 'formalParameterSection_is_variableParameterSpecification' => 'formal_parameter_section', [ 'variable_parameter_specification' ], 0 ],
  [ 'formalParameterSection_is_proceduralParameterSpecification' => 'formal_parameter_section', [ 'procedural_parameter_specification' ], 0 ],
  [ 'formalParameterSection_is_functionalParameterSpecification' => 'formal_parameter_section', [ 'functional_parameter_specification' ], 0 ],
  [ 'valueParameterSpecification_is_identifierList_COLON_identifier' => 'value_parameter_specification', [ 'identifier_list', 'COLON', 'identifier' ], 0 ],
  [ 'variableParameterSpecification_is_VAR_identifierList_COLON_identifier' => 'variable_parameter_specification', [ 'VAR', 'identifier_list', 'COLON', 'identifier' ], 0 ],
  [ 'proceduralParameterSpecification_is_procedureHeading' => 'procedural_parameter_specification', [ 'procedure_heading' ], 0 ],
  [ 'functionalParameterSpecification_is_functionHeading' => 'functional_parameter_specification', [ 'function_heading' ], 0 ],
  [ 'procedureIdentification_is_PROCEDURE_identifier' => 'procedure_identification', [ 'PROCEDURE', 'identifier' ], 0 ],
  [ 'procedureBlock_is_block' => 'procedure_block', [ 'block' ], 0 ],
  [ 'functionDeclaration_is_functionHeading_semicolon_directive' => 'function_declaration', [ 'function_heading', 'semicolon', 'directive' ], 0 ],
  [ 'functionDeclaration_is_functionIdentification_semicolon_functionBlock' => 'function_declaration', [ 'function_identification', 'semicolon', 'function_block' ], 0 ],
  [ 'functionDeclaration_is_functionHeading_semicolon_functionBlock' => 'function_declaration', [ 'function_heading', 'semicolon', 'function_block' ], 0 ],
  [ 'functionHeading_is_FUNCTION_identifier_COLON_resultType' => 'function_heading', [ 'FUNCTION', 'identifier', 'COLON', 'result_type' ], 0 ],
  [ 'functionHeading_is_FUNCTION_identifier_formalParameterList_COLON_resultType' => 'function_heading', [ 'FUNCTION', 'identifier', 'formal_parameter_list', 'COLON', 'result_type' ], 0 ],
  [ 'resultType_is_identifier' => 'result_type', [ 'identifier' ], 0 ],
  [ 'functionIdentification_is_FUNCTION_identifier' => 'function_identification', [ 'FUNCTION', 'identifier' ], 0 ],
  [ 'functionBlock_is_block' => 'function_block', [ 'block' ], 0 ],
  [ 'statementPart_is_compoundStatement' => 'statement_part', [ 'compound_statement' ], 0 ],
  [ 'compoundStatement_is_PBEGIN_statementSequence_END' => 'compound_statement', [ 'PBEGIN', 'statement_sequence', 'END' ], 0 ],
  [ 'statementSequence_is_statementSequence_semicolon_statement' => 'statement_sequence', [ 'statement_sequence', 'semicolon', 'statement' ], 0 ],
  [ 'statementSequence_is_statement' => 'statement_sequence', [ 'statement' ], 0 ],
  [ 'statement_is_openStatement' => 'statement', [ 'open_statement' ], 0 ],
  [ 'statement_is_closedStatement' => 'statement', [ 'closed_statement' ], 0 ],
  [ 'openStatement_is_label_COLON_nonLabeledOpenStatement' => 'open_statement', [ 'label', 'COLON', 'non_labeled_open_statement' ], 0 ],
  [ 'openStatement_is_nonLabeledOpenStatement' => 'open_statement', [ 'non_labeled_open_statement' ], 0 ],
  [ 'closedStatement_is_label_COLON_nonLabeledClosedStatement' => 'closed_statement', [ 'label', 'COLON', 'non_labeled_closed_statement' ], 0 ],
  [ 'closedStatement_is_nonLabeledClosedStatement' => 'closed_statement', [ 'non_labeled_closed_statement' ], 0 ],
  [ 'nonLabeledClosedStatement_is_assignmentStatement' => 'non_labeled_closed_statement', [ 'assignment_statement' ], 0 ],
  [ 'nonLabeledClosedStatement_is_procedureStatement' => 'non_labeled_closed_statement', [ 'procedure_statement' ], 0 ],
  [ 'nonLabeledClosedStatement_is_gotoStatement' => 'non_labeled_closed_statement', [ 'goto_statement' ], 0 ],
  [ 'nonLabeledClosedStatement_is_compoundStatement' => 'non_labeled_closed_statement', [ 'compound_statement' ], 0 ],
  [ 'nonLabeledClosedStatement_is_caseStatement' => 'non_labeled_closed_statement', [ 'case_statement' ], 0 ],
  [ 'nonLabeledClosedStatement_is_repeatStatement' => 'non_labeled_closed_statement', [ 'repeat_statement' ], 0 ],
  [ 'nonLabeledClosedStatement_is_closedWithStatement' => 'non_labeled_closed_statement', [ 'closed_with_statement' ], 0 ],
  [ 'nonLabeledClosedStatement_is_closedIfStatement' => 'non_labeled_closed_statement', [ 'closed_if_statement' ], 0 ],
  [ 'nonLabeledClosedStatement_is_closedWhileStatement' => 'non_labeled_closed_statement', [ 'closed_while_statement' ], 0 ],
  [ 'nonLabeledClosedStatement_is_closedForStatement' => 'non_labeled_closed_statement', [ 'closed_for_statement' ], 0 ],
  [ 'nonLabeledClosedStatement_is_empty' => 'non_labeled_closed_statement', [  ], 0 ],
  [ 'nonLabeledOpenStatement_is_openWithStatement' => 'non_labeled_open_statement', [ 'open_with_statement' ], 0 ],
  [ 'nonLabeledOpenStatement_is_openIfStatement' => 'non_labeled_open_statement', [ 'open_if_statement' ], 0 ],
  [ 'nonLabeledOpenStatement_is_openWhileStatement' => 'non_labeled_open_statement', [ 'open_while_statement' ], 0 ],
  [ 'nonLabeledOpenStatement_is_openForStatement' => 'non_labeled_open_statement', [ 'open_for_statement' ], 0 ],
  [ 'repeatStatement_is_REPEAT_statementSequence_UNTIL_booleanExpression' => 'repeat_statement', [ 'REPEAT', 'statement_sequence', 'UNTIL', 'boolean_expression' ], 0 ],
  [ 'openWhileStatement_is_WHILE_booleanExpression_DO_openStatement' => 'open_while_statement', [ 'WHILE', 'boolean_expression', 'DO', 'open_statement' ], 0 ],
  [ 'closedWhileStatement_is_WHILE_booleanExpression_DO_closedStatement' => 'closed_while_statement', [ 'WHILE', 'boolean_expression', 'DO', 'closed_statement' ], 0 ],
  [ 'openForStatement_is_FOR_controlVariable_ASSIGNMENT_initialValue_direction_finalValue_DO_openStatement' => 'open_for_statement', [ 'FOR', 'control_variable', 'ASSIGNMENT', 'initial_value', 'direction', 'final_value', 'DO', 'open_statement' ], 0 ],
  [ 'closedForStatement_is_FOR_controlVariable_ASSIGNMENT_initialValue_direction_finalValue_DO_closedStatement' => 'closed_for_statement', [ 'FOR', 'control_variable', 'ASSIGNMENT', 'initial_value', 'direction', 'final_value', 'DO', 'closed_statement' ], 0 ],
  [ 'openWithStatement_is_WITH_recordVariableList_DO_openStatement' => 'open_with_statement', [ 'WITH', 'record_variable_list', 'DO', 'open_statement' ], 0 ],
  [ 'closedWithStatement_is_WITH_recordVariableList_DO_closedStatement' => 'closed_with_statement', [ 'WITH', 'record_variable_list', 'DO', 'closed_statement' ], 0 ],
  [ 'openIfStatement_is_IF_booleanExpression_THEN_statement' => 'open_if_statement', [ 'IF', 'boolean_expression', 'THEN', 'statement' ], 0 ],
  [ 'openIfStatement_is_IF_booleanExpression_THEN_closedStatement_ELSE_openStatement' => 'open_if_statement', [ 'IF', 'boolean_expression', 'THEN', 'closed_statement', 'ELSE', 'open_statement' ], 0 ],
  [ 'closedIfStatement_is_IF_booleanExpression_THEN_closedStatement_ELSE_closedStatement' => 'closed_if_statement', [ 'IF', 'boolean_expression', 'THEN', 'closed_statement', 'ELSE', 'closed_statement' ], 0 ],
  [ 'assignmentStatement_is_variableAccess_ASSIGNMENT_expression' => 'assignment_statement', [ 'variable_access', 'ASSIGNMENT', 'expression' ], 0 ],
  [ 'variableAccess_is_identifier' => 'variable_access', [ 'identifier' ], 0 ],
  [ 'variableAccess_is_indexedVariable' => 'variable_access', [ 'indexed_variable' ], 0 ],
  [ 'variableAccess_is_fieldDesignator' => 'variable_access', [ 'field_designator' ], 0 ],
  [ 'variableAccess_is_variableAccess_UPARROW' => 'variable_access', [ 'variable_access', 'UPARROW' ], 0 ],
  [ 'indexedVariable_is_variableAccess_LBRAC_indexExpressionList_RBRAC' => 'indexed_variable', [ 'variable_access', 'LBRAC', 'index_expression_list', 'RBRAC' ], 0 ],
  [ 'indexExpressionList_is_indexExpressionList_comma_indexExpression' => 'index_expression_list', [ 'index_expression_list', 'comma', 'index_expression' ], 0 ],
  [ 'indexExpressionList_is_indexExpression' => 'index_expression_list', [ 'index_expression' ], 0 ],
  [ 'indexExpression_is_expression' => 'index_expression', [ 'expression' ], 0 ],
  [ 'fieldDesignator_is_variableAccess_DOT_identifier' => 'field_designator', [ 'variable_access', 'DOT', 'identifier' ], 0 ],
  [ 'procedureStatement_is_identifier_params' => 'procedure_statement', [ 'identifier', 'params' ], 0 ],
  [ 'procedureStatement_is_identifier' => 'procedure_statement', [ 'identifier' ], 0 ],
  [ 'params_is_LPAREN_actualParameterList_RPAREN' => 'params', [ 'LPAREN', 'actual_parameter_list', 'RPAREN' ], 0 ],
  [ 'actualParameterList_is_actualParameterList_comma_actualParameter' => 'actual_parameter_list', [ 'actual_parameter_list', 'comma', 'actual_parameter' ], 0 ],
  [ 'actualParameterList_is_actualParameter' => 'actual_parameter_list', [ 'actual_parameter' ], 0 ],
  [ 'actualParameter_is_expression' => 'actual_parameter', [ 'expression' ], 0 ],
  [ 'actualParameter_is_expression_COLON_expression' => 'actual_parameter', [ 'expression', 'COLON', 'expression' ], 0 ],
  [ 'actualParameter_is_expression_COLON_expression_COLON_expression' => 'actual_parameter', [ 'expression', 'COLON', 'expression', 'COLON', 'expression' ], 0 ],
  [ 'gotoStatement_is_GOTO_label' => 'goto_statement', [ 'GOTO', 'label' ], 0 ],
  [ 'caseStatement_is_CASE_caseIndex_OF_caseListElementList_END' => 'case_statement', [ 'CASE', 'case_index', 'OF', 'case_list_element_list', 'END' ], 0 ],
  [ 'caseStatement_is_CASE_caseIndex_OF_caseListElementList_SEMICOLON_END' => 'case_statement', [ 'CASE', 'case_index', 'OF', 'case_list_element_list', 'SEMICOLON', 'END' ], 0 ],
  [ 'caseStatement_is_CASE_caseIndex_OF_caseListElementList_semicolon_otherwisepart_statement_END' => 'case_statement', [ 'CASE', 'case_index', 'OF', 'case_list_element_list', 'semicolon', 'otherwisepart', 'statement', 'END' ], 0 ],
  [ 'caseStatement_is_CASE_caseIndex_OF_caseListElementList_semicolon_otherwisepart_statement_SEMICOLON_END' => 'case_statement', [ 'CASE', 'case_index', 'OF', 'case_list_element_list', 'semicolon', 'otherwisepart', 'statement', 'SEMICOLON', 'END' ], 0 ],
  [ 'caseIndex_is_expression' => 'case_index', [ 'expression' ], 0 ],
  [ 'caseListElementList_is_caseListElementList_semicolon_caseListElement' => 'case_list_element_list', [ 'case_list_element_list', 'semicolon', 'case_list_element' ], 0 ],
  [ 'caseListElementList_is_caseListElement' => 'case_list_element_list', [ 'case_list_element' ], 0 ],
  [ 'caseListElement_is_caseConstantList_COLON_statement' => 'case_list_element', [ 'case_constant_list', 'COLON', 'statement' ], 0 ],
  [ 'otherwisepart_is_OTHERWISE' => 'otherwisepart', [ 'OTHERWISE' ], 0 ],
  [ 'otherwisepart_is_OTHERWISE_COLON' => 'otherwisepart', [ 'OTHERWISE', 'COLON' ], 0 ],
  [ 'controlVariable_is_identifier' => 'control_variable', [ 'identifier' ], 0 ],
  [ 'initialValue_is_expression' => 'initial_value', [ 'expression' ], 0 ],
  [ 'direction_is_TO' => 'direction', [ 'TO' ], 0 ],
  [ 'direction_is_DOWNTO' => 'direction', [ 'DOWNTO' ], 0 ],
  [ 'finalValue_is_expression' => 'final_value', [ 'expression' ], 0 ],
  [ 'recordVariableList_is_recordVariableList_comma_variableAccess' => 'record_variable_list', [ 'record_variable_list', 'comma', 'variable_access' ], 0 ],
  [ 'recordVariableList_is_variableAccess' => 'record_variable_list', [ 'variable_access' ], 0 ],
  [ 'booleanExpression_is_expression' => 'boolean_expression', [ 'expression' ], 0 ],
  [ 'expression_is_simpleExpression' => 'expression', [ 'simple_expression' ], 0 ],
  [ 'expression_is_simpleExpression_relop_simpleExpression' => 'expression', [ 'simple_expression', 'relop', 'simple_expression' ], 0 ],
  [ 'simpleExpression_is_term' => 'simple_expression', [ 'term' ], 0 ],
  [ 'simpleExpression_is_simpleExpression_addop_term' => 'simple_expression', [ 'simple_expression', 'addop', 'term' ], 0 ],
  [ 'term_is_factor' => 'term', [ 'factor' ], 0 ],
  [ 'term_is_term_mulop_factor' => 'term', [ 'term', 'mulop', 'factor' ], 0 ],
  [ 'factor_is_sign_factor' => 'factor', [ 'sign', 'factor' ], 0 ],
  [ 'factor_is_exponentiation' => 'factor', [ 'exponentiation' ], 0 ],
  [ 'exponentiation_is_primary' => 'exponentiation', [ 'primary' ], 0 ],
  [ 'exponentiation_is_primary_STARSTAR_exponentiation' => 'exponentiation', [ 'primary', 'STARSTAR', 'exponentiation' ], 0 ],
  [ 'primary_is_variableAccess' => 'primary', [ 'variable_access' ], 0 ],
  [ 'primary_is_unsignedConstant' => 'primary', [ 'unsigned_constant' ], 0 ],
  [ 'primary_is_functionDesignator' => 'primary', [ 'function_designator' ], 0 ],
  [ 'primary_is_setConstructor' => 'primary', [ 'set_constructor' ], 0 ],
  [ 'primary_is_LPAREN_expression_RPAREN' => 'primary', [ 'LPAREN', 'expression', 'RPAREN' ], 0 ],
  [ 'primary_is_NOT_primary' => 'primary', [ 'NOT', 'primary' ], 0 ],
  [ 'unsignedConstant_is_unsignedNumber' => 'unsigned_constant', [ 'unsigned_number' ], 0 ],
  [ 'unsignedConstant_is_CHARACTER_STRING' => 'unsigned_constant', [ 'CHARACTER_STRING' ], 0 ],
  [ 'unsignedConstant_is_NIL' => 'unsigned_constant', [ 'NIL' ], 0 ],
  [ 'unsignedNumber_is_unsignedInteger' => 'unsigned_number', [ 'unsigned_integer' ], 0 ],
  [ 'unsignedNumber_is_unsignedReal' => 'unsigned_number', [ 'unsigned_real' ], 0 ],
  [ 'unsignedInteger_is_DIGSEQ' => 'unsigned_integer', [ 'DIGSEQ' ], 0 ],
  [ 'unsignedReal_is_REALNUMBER' => 'unsigned_real', [ 'REALNUMBER' ], 0 ],
  [ 'functionDesignator_is_identifier_params' => 'function_designator', [ 'identifier', 'params' ], 0 ],
  [ 'setConstructor_is_LBRAC_memberDesignatorList_RBRAC' => 'set_constructor', [ 'LBRAC', 'member_designator_list', 'RBRAC' ], 0 ],
  [ 'setConstructor_is_LBRAC_RBRAC' => 'set_constructor', [ 'LBRAC', 'RBRAC' ], 0 ],
  [ 'memberDesignatorList_is_memberDesignatorList_comma_memberDesignator' => 'member_designator_list', [ 'member_designator_list', 'comma', 'member_designator' ], 0 ],
  [ 'memberDesignatorList_is_memberDesignator' => 'member_designator_list', [ 'member_designator' ], 0 ],
  [ 'memberDesignator_is_memberDesignator_DOTDOT_expression' => 'member_designator', [ 'member_designator', 'DOTDOT', 'expression' ], 0 ],
  [ 'memberDesignator_is_expression' => 'member_designator', [ 'expression' ], 0 ],
  [ 'addop_is_PLUS' => 'addop', [ 'PLUS' ], 0 ],
  [ 'addop_is_MINUS' => 'addop', [ 'MINUS' ], 0 ],
  [ 'addop_is_OR' => 'addop', [ 'OR' ], 0 ],
  [ 'mulop_is_STAR' => 'mulop', [ 'STAR' ], 0 ],
  [ 'mulop_is_SLASH' => 'mulop', [ 'SLASH' ], 0 ],
  [ 'mulop_is_DIV' => 'mulop', [ 'DIV' ], 0 ],
  [ 'mulop_is_MOD' => 'mulop', [ 'MOD' ], 0 ],
  [ 'mulop_is_AND' => 'mulop', [ 'AND' ], 0 ],
  [ 'relop_is_EQUAL' => 'relop', [ 'EQUAL' ], 0 ],
  [ 'relop_is_NOTEQUAL' => 'relop', [ 'NOTEQUAL' ], 0 ],
  [ 'relop_is_LT' => 'relop', [ 'LT' ], 0 ],
  [ 'relop_is_GT' => 'relop', [ 'GT' ], 0 ],
  [ 'relop_is_LE' => 'relop', [ 'LE' ], 0 ],
  [ 'relop_is_GE' => 'relop', [ 'GE' ], 0 ],
  [ 'relop_is_IN' => 'relop', [ 'IN' ], 0 ],
  [ 'identifier_is_IDENTIFIER' => 'identifier', [ 'IDENTIFIER' ], 0 ],
  [ 'semicolon_is_SEMICOLON' => 'semicolon', [ 'SEMICOLON' ], 0 ],
  [ 'comma_is_COMMA' => 'comma', [ 'COMMA' ], 0 ],
],
    yyLABELS  =>
{
  '_SUPERSTART' => 0,
  'file_is_program' => 1,
  'file_is_module' => 2,
  'program_is_programHeading_semicolon_block_DOT' => 3,
  'programHeading_is_PROGRAM_identifier' => 4,
  'programHeading_is_PROGRAM_identifier_LPAREN_identifierList_RPAREN' => 5,
  'identifierList_is_identifierList_comma_identifier' => 6,
  'identifierList_is_identifier' => 7,
  'block_is_labelDeclarationPart_constantDefinitionPart_typeDefinitionPart_variableDeclarationPart_procedureAndFunctionDeclarationPart_statementPart' => 8,
  'module_is_constantDefinitionPart_typeDefinitionPart_variableDeclarationPart_procedureAndFunctionDeclarationPart' => 9,
  'labelDeclarationPart_is_LABEL_labelList_semicolon' => 10,
  'labelDeclarationPart_is_empty' => 11,
  'labelList_is_labelList_comma_label' => 12,
  'labelList_is_label' => 13,
  'label_is_DIGSEQ' => 14,
  'constantDefinitionPart_is_CONST_constantList' => 15,
  'constantDefinitionPart_is_empty' => 16,
  'constantList_is_constantList_constantDefinition' => 17,
  'constantList_is_constantDefinition' => 18,
  'constantDefinition_is_identifier_EQUAL_cexpression_semicolon' => 19,
  'cexpression_is_csimpleExpression' => 20,
  'cexpression_is_csimpleExpression_relop_csimpleExpression' => 21,
  'csimpleExpression_is_cterm' => 22,
  'csimpleExpression_is_csimpleExpression_addop_cterm' => 23,
  'cterm_is_cfactor' => 24,
  'cterm_is_cterm_mulop_cfactor' => 25,
  'cfactor_is_sign_cfactor' => 26,
  'cfactor_is_cexponentiation' => 27,
  'cexponentiation_is_cprimary' => 28,
  'cexponentiation_is_cprimary_STARSTAR_cexponentiation' => 29,
  'cprimary_is_identifier' => 30,
  'cprimary_is_LPAREN_cexpression_RPAREN' => 31,
  'cprimary_is_unsignedConstant' => 32,
  'cprimary_is_NOT_cprimary' => 33,
  'constant_is_nonString' => 34,
  'constant_is_sign_nonString' => 35,
  'constant_is_CHARACTER_STRING' => 36,
  'sign_is_PLUS' => 37,
  'sign_is_MINUS' => 38,
  'nonString_is_DIGSEQ' => 39,
  'nonString_is_identifier' => 40,
  'nonString_is_REALNUMBER' => 41,
  'typeDefinitionPart_is_TYPE_typeDefinitionList' => 42,
  'typeDefinitionPart_is_empty' => 43,
  'typeDefinitionList_is_typeDefinitionList_typeDefinition' => 44,
  'typeDefinitionList_is_typeDefinition' => 45,
  'typeDefinition_is_identifier_EQUAL_typeDenoter_semicolon' => 46,
  'typeDenoter_is_identifier' => 47,
  'typeDenoter_is_newType' => 48,
  'newType_is_newOrdinalType' => 49,
  'newType_is_newStructuredType' => 50,
  'newType_is_newPointerType' => 51,
  'newOrdinalType_is_enumeratedType' => 52,
  'newOrdinalType_is_subrangeType' => 53,
  'enumeratedType_is_LPAREN_identifierList_RPAREN' => 54,
  'subrangeType_is_constant_DOTDOT_constant' => 55,
  'newStructuredType_is_structuredType' => 56,
  'newStructuredType_is_PACKED_structuredType' => 57,
  'structuredType_is_arrayType' => 58,
  'structuredType_is_recordType' => 59,
  'structuredType_is_setType' => 60,
  'structuredType_is_fileType' => 61,
  'arrayType_is_ARRAY_LBRAC_indexList_RBRAC_OF_componentType' => 62,
  'indexList_is_indexList_comma_indexType' => 63,
  'indexList_is_indexType' => 64,
  'indexType_is_ordinalType' => 65,
  'ordinalType_is_newOrdinalType' => 66,
  'ordinalType_is_identifier' => 67,
  'componentType_is_typeDenoter' => 68,
  'recordType_is_RECORD_recordSectionList_END' => 69,
  'recordType_is_RECORD_recordSectionList_semicolon_variantPart_END' => 70,
  'recordType_is_RECORD_variantPart_END' => 71,
  'recordSectionList_is_recordSectionList_semicolon_recordSection' => 72,
  'recordSectionList_is_recordSection' => 73,
  'recordSection_is_identifierList_COLON_typeDenoter' => 74,
  'variantPart_is_CASE_variantSelector_OF_variantList_semicolon' => 75,
  'variantPart_is_CASE_variantSelector_OF_variantList' => 76,
  'variantPart_is_empty' => 77,
  'variantSelector_is_tagField_COLON_tagType' => 78,
  'variantSelector_is_tagType' => 79,
  'variantList_is_variantList_semicolon_variant' => 80,
  'variantList_is_variant' => 81,
  'variant_is_caseConstantList_COLON_LPAREN_recordSectionList_RPAREN' => 82,
  'variant_is_caseConstantList_COLON_LPAREN_recordSectionList_semicolon_variantPart_RPAREN' => 83,
  'variant_is_caseConstantList_COLON_LPAREN_variantPart_RPAREN' => 84,
  'caseConstantList_is_caseConstantList_comma_caseConstant' => 85,
  'caseConstantList_is_caseConstant' => 86,
  'caseConstant_is_constant' => 87,
  'caseConstant_is_constant_DOTDOT_constant' => 88,
  'tagField_is_identifier' => 89,
  'tagType_is_identifier' => 90,
  'setType_is_SET_OF_baseType' => 91,
  'baseType_is_ordinalType' => 92,
  'fileType_is_PFILE_OF_componentType' => 93,
  'newPointerType_is_UPARROW_domainType' => 94,
  'domainType_is_identifier' => 95,
  'variableDeclarationPart_is_VAR_variableDeclarationList_semicolon' => 96,
  'variableDeclarationPart_is_empty' => 97,
  'variableDeclarationList_is_variableDeclarationList_semicolon_variableDeclaration' => 98,
  'variableDeclarationList_is_variableDeclaration' => 99,
  'variableDeclaration_is_identifierList_COLON_typeDenoter' => 100,
  'procedureAndFunctionDeclarationPart_is_procOrFuncDeclarationList_semicolon' => 101,
  'procedureAndFunctionDeclarationPart_is_empty' => 102,
  'procOrFuncDeclarationList_is_procOrFuncDeclarationList_semicolon_procOrFuncDeclaration' => 103,
  'procOrFuncDeclarationList_is_procOrFuncDeclaration' => 104,
  'procOrFuncDeclaration_is_procedureDeclaration' => 105,
  'procOrFuncDeclaration_is_functionDeclaration' => 106,
  'procedureDeclaration_is_procedureHeading_semicolon_directive' => 107,
  'procedureDeclaration_is_procedureHeading_semicolon_procedureBlock' => 108,
  'procedureHeading_is_procedureIdentification' => 109,
  'procedureHeading_is_procedureIdentification_formalParameterList' => 110,
  'directive_is_FORWARD' => 111,
  'directive_is_EXTERNAL' => 112,
  'formalParameterList_is_LPAREN_formalParameterSectionList_RPAREN' => 113,
  'formalParameterSectionList_is_formalParameterSectionList_semicolon_formalParameterSection' => 114,
  'formalParameterSectionList_is_formalParameterSection' => 115,
  'formalParameterSection_is_valueParameterSpecification' => 116,
  'formalParameterSection_is_variableParameterSpecification' => 117,
  'formalParameterSection_is_proceduralParameterSpecification' => 118,
  'formalParameterSection_is_functionalParameterSpecification' => 119,
  'valueParameterSpecification_is_identifierList_COLON_identifier' => 120,
  'variableParameterSpecification_is_VAR_identifierList_COLON_identifier' => 121,
  'proceduralParameterSpecification_is_procedureHeading' => 122,
  'functionalParameterSpecification_is_functionHeading' => 123,
  'procedureIdentification_is_PROCEDURE_identifier' => 124,
  'procedureBlock_is_block' => 125,
  'functionDeclaration_is_functionHeading_semicolon_directive' => 126,
  'functionDeclaration_is_functionIdentification_semicolon_functionBlock' => 127,
  'functionDeclaration_is_functionHeading_semicolon_functionBlock' => 128,
  'functionHeading_is_FUNCTION_identifier_COLON_resultType' => 129,
  'functionHeading_is_FUNCTION_identifier_formalParameterList_COLON_resultType' => 130,
  'resultType_is_identifier' => 131,
  'functionIdentification_is_FUNCTION_identifier' => 132,
  'functionBlock_is_block' => 133,
  'statementPart_is_compoundStatement' => 134,
  'compoundStatement_is_PBEGIN_statementSequence_END' => 135,
  'statementSequence_is_statementSequence_semicolon_statement' => 136,
  'statementSequence_is_statement' => 137,
  'statement_is_openStatement' => 138,
  'statement_is_closedStatement' => 139,
  'openStatement_is_label_COLON_nonLabeledOpenStatement' => 140,
  'openStatement_is_nonLabeledOpenStatement' => 141,
  'closedStatement_is_label_COLON_nonLabeledClosedStatement' => 142,
  'closedStatement_is_nonLabeledClosedStatement' => 143,
  'nonLabeledClosedStatement_is_assignmentStatement' => 144,
  'nonLabeledClosedStatement_is_procedureStatement' => 145,
  'nonLabeledClosedStatement_is_gotoStatement' => 146,
  'nonLabeledClosedStatement_is_compoundStatement' => 147,
  'nonLabeledClosedStatement_is_caseStatement' => 148,
  'nonLabeledClosedStatement_is_repeatStatement' => 149,
  'nonLabeledClosedStatement_is_closedWithStatement' => 150,
  'nonLabeledClosedStatement_is_closedIfStatement' => 151,
  'nonLabeledClosedStatement_is_closedWhileStatement' => 152,
  'nonLabeledClosedStatement_is_closedForStatement' => 153,
  'nonLabeledClosedStatement_is_empty' => 154,
  'nonLabeledOpenStatement_is_openWithStatement' => 155,
  'nonLabeledOpenStatement_is_openIfStatement' => 156,
  'nonLabeledOpenStatement_is_openWhileStatement' => 157,
  'nonLabeledOpenStatement_is_openForStatement' => 158,
  'repeatStatement_is_REPEAT_statementSequence_UNTIL_booleanExpression' => 159,
  'openWhileStatement_is_WHILE_booleanExpression_DO_openStatement' => 160,
  'closedWhileStatement_is_WHILE_booleanExpression_DO_closedStatement' => 161,
  'openForStatement_is_FOR_controlVariable_ASSIGNMENT_initialValue_direction_finalValue_DO_openStatement' => 162,
  'closedForStatement_is_FOR_controlVariable_ASSIGNMENT_initialValue_direction_finalValue_DO_closedStatement' => 163,
  'openWithStatement_is_WITH_recordVariableList_DO_openStatement' => 164,
  'closedWithStatement_is_WITH_recordVariableList_DO_closedStatement' => 165,
  'openIfStatement_is_IF_booleanExpression_THEN_statement' => 166,
  'openIfStatement_is_IF_booleanExpression_THEN_closedStatement_ELSE_openStatement' => 167,
  'closedIfStatement_is_IF_booleanExpression_THEN_closedStatement_ELSE_closedStatement' => 168,
  'assignmentStatement_is_variableAccess_ASSIGNMENT_expression' => 169,
  'variableAccess_is_identifier' => 170,
  'variableAccess_is_indexedVariable' => 171,
  'variableAccess_is_fieldDesignator' => 172,
  'variableAccess_is_variableAccess_UPARROW' => 173,
  'indexedVariable_is_variableAccess_LBRAC_indexExpressionList_RBRAC' => 174,
  'indexExpressionList_is_indexExpressionList_comma_indexExpression' => 175,
  'indexExpressionList_is_indexExpression' => 176,
  'indexExpression_is_expression' => 177,
  'fieldDesignator_is_variableAccess_DOT_identifier' => 178,
  'procedureStatement_is_identifier_params' => 179,
  'procedureStatement_is_identifier' => 180,
  'params_is_LPAREN_actualParameterList_RPAREN' => 181,
  'actualParameterList_is_actualParameterList_comma_actualParameter' => 182,
  'actualParameterList_is_actualParameter' => 183,
  'actualParameter_is_expression' => 184,
  'actualParameter_is_expression_COLON_expression' => 185,
  'actualParameter_is_expression_COLON_expression_COLON_expression' => 186,
  'gotoStatement_is_GOTO_label' => 187,
  'caseStatement_is_CASE_caseIndex_OF_caseListElementList_END' => 188,
  'caseStatement_is_CASE_caseIndex_OF_caseListElementList_SEMICOLON_END' => 189,
  'caseStatement_is_CASE_caseIndex_OF_caseListElementList_semicolon_otherwisepart_statement_END' => 190,
  'caseStatement_is_CASE_caseIndex_OF_caseListElementList_semicolon_otherwisepart_statement_SEMICOLON_END' => 191,
  'caseIndex_is_expression' => 192,
  'caseListElementList_is_caseListElementList_semicolon_caseListElement' => 193,
  'caseListElementList_is_caseListElement' => 194,
  'caseListElement_is_caseConstantList_COLON_statement' => 195,
  'otherwisepart_is_OTHERWISE' => 196,
  'otherwisepart_is_OTHERWISE_COLON' => 197,
  'controlVariable_is_identifier' => 198,
  'initialValue_is_expression' => 199,
  'direction_is_TO' => 200,
  'direction_is_DOWNTO' => 201,
  'finalValue_is_expression' => 202,
  'recordVariableList_is_recordVariableList_comma_variableAccess' => 203,
  'recordVariableList_is_variableAccess' => 204,
  'booleanExpression_is_expression' => 205,
  'expression_is_simpleExpression' => 206,
  'expression_is_simpleExpression_relop_simpleExpression' => 207,
  'simpleExpression_is_term' => 208,
  'simpleExpression_is_simpleExpression_addop_term' => 209,
  'term_is_factor' => 210,
  'term_is_term_mulop_factor' => 211,
  'factor_is_sign_factor' => 212,
  'factor_is_exponentiation' => 213,
  'exponentiation_is_primary' => 214,
  'exponentiation_is_primary_STARSTAR_exponentiation' => 215,
  'primary_is_variableAccess' => 216,
  'primary_is_unsignedConstant' => 217,
  'primary_is_functionDesignator' => 218,
  'primary_is_setConstructor' => 219,
  'primary_is_LPAREN_expression_RPAREN' => 220,
  'primary_is_NOT_primary' => 221,
  'unsignedConstant_is_unsignedNumber' => 222,
  'unsignedConstant_is_CHARACTER_STRING' => 223,
  'unsignedConstant_is_NIL' => 224,
  'unsignedNumber_is_unsignedInteger' => 225,
  'unsignedNumber_is_unsignedReal' => 226,
  'unsignedInteger_is_DIGSEQ' => 227,
  'unsignedReal_is_REALNUMBER' => 228,
  'functionDesignator_is_identifier_params' => 229,
  'setConstructor_is_LBRAC_memberDesignatorList_RBRAC' => 230,
  'setConstructor_is_LBRAC_RBRAC' => 231,
  'memberDesignatorList_is_memberDesignatorList_comma_memberDesignator' => 232,
  'memberDesignatorList_is_memberDesignator' => 233,
  'memberDesignator_is_memberDesignator_DOTDOT_expression' => 234,
  'memberDesignator_is_expression' => 235,
  'addop_is_PLUS' => 236,
  'addop_is_MINUS' => 237,
  'addop_is_OR' => 238,
  'mulop_is_STAR' => 239,
  'mulop_is_SLASH' => 240,
  'mulop_is_DIV' => 241,
  'mulop_is_MOD' => 242,
  'mulop_is_AND' => 243,
  'relop_is_EQUAL' => 244,
  'relop_is_NOTEQUAL' => 245,
  'relop_is_LT' => 246,
  'relop_is_GT' => 247,
  'relop_is_LE' => 248,
  'relop_is_GE' => 249,
  'relop_is_IN' => 250,
  'identifier_is_IDENTIFIER' => 251,
  'semicolon_is_SEMICOLON' => 252,
  'comma_is_COMMA' => 253,
},
    yyTERMS  =>
{ '' => { ISSEMANTIC => 0 },
	AND => { ISSEMANTIC => 1 },
	ARRAY => { ISSEMANTIC => 1 },
	ASSIGNMENT => { ISSEMANTIC => 1 },
	CASE => { ISSEMANTIC => 1 },
	CHARACTER_STRING => { ISSEMANTIC => 1 },
	COLON => { ISSEMANTIC => 1 },
	COMMA => { ISSEMANTIC => 1 },
	CONST => { ISSEMANTIC => 1 },
	DIGSEQ => { ISSEMANTIC => 1 },
	DIV => { ISSEMANTIC => 1 },
	DO => { ISSEMANTIC => 1 },
	DOT => { ISSEMANTIC => 1 },
	DOTDOT => { ISSEMANTIC => 1 },
	DOWNTO => { ISSEMANTIC => 1 },
	ELSE => { ISSEMANTIC => 1 },
	END => { ISSEMANTIC => 1 },
	EQUAL => { ISSEMANTIC => 1 },
	EXTERNAL => { ISSEMANTIC => 1 },
	FOR => { ISSEMANTIC => 1 },
	FORWARD => { ISSEMANTIC => 1 },
	FUNCTION => { ISSEMANTIC => 1 },
	GE => { ISSEMANTIC => 1 },
	GOTO => { ISSEMANTIC => 1 },
	GT => { ISSEMANTIC => 1 },
	IDENTIFIER => { ISSEMANTIC => 1 },
	IF => { ISSEMANTIC => 1 },
	IN => { ISSEMANTIC => 1 },
	LABEL => { ISSEMANTIC => 1 },
	LBRAC => { ISSEMANTIC => 1 },
	LE => { ISSEMANTIC => 1 },
	LPAREN => { ISSEMANTIC => 1 },
	LT => { ISSEMANTIC => 1 },
	MINUS => { ISSEMANTIC => 1 },
	MOD => { ISSEMANTIC => 1 },
	NIL => { ISSEMANTIC => 1 },
	NOT => { ISSEMANTIC => 1 },
	NOTEQUAL => { ISSEMANTIC => 1 },
	OF => { ISSEMANTIC => 1 },
	OR => { ISSEMANTIC => 1 },
	OTHERWISE => { ISSEMANTIC => 1 },
	PACKED => { ISSEMANTIC => 1 },
	PBEGIN => { ISSEMANTIC => 1 },
	PFILE => { ISSEMANTIC => 1 },
	PLUS => { ISSEMANTIC => 1 },
	PROCEDURE => { ISSEMANTIC => 1 },
	PROGRAM => { ISSEMANTIC => 1 },
	RBRAC => { ISSEMANTIC => 1 },
	REALNUMBER => { ISSEMANTIC => 1 },
	RECORD => { ISSEMANTIC => 1 },
	REPEAT => { ISSEMANTIC => 1 },
	RPAREN => { ISSEMANTIC => 1 },
	SEMICOLON => { ISSEMANTIC => 1 },
	SET => { ISSEMANTIC => 1 },
	SLASH => { ISSEMANTIC => 1 },
	STAR => { ISSEMANTIC => 1 },
	STARSTAR => { ISSEMANTIC => 1 },
	THEN => { ISSEMANTIC => 1 },
	TO => { ISSEMANTIC => 1 },
	TYPE => { ISSEMANTIC => 1 },
	UNTIL => { ISSEMANTIC => 1 },
	UPARROW => { ISSEMANTIC => 1 },
	VAR => { ISSEMANTIC => 1 },
	WHILE => { ISSEMANTIC => 1 },
	WITH => { ISSEMANTIC => 1 },
	error => { ISSEMANTIC => 0 },
},
    yyFILENAME  => 'pascal.eyp',
    yystates =>
[
	{#State 0
		ACTIONS => {
			'PROGRAM' => 5,
			'CONST' => 3
		},
		DEFAULT => -16,
		GOTOS => {
			'constant_definition_part' => 4,
			'file' => 6,
			'program' => 7,
			'module' => 1,
			'program_heading' => 2
		}
	},
	{#State 1
		DEFAULT => -2
	},
	{#State 2
		ACTIONS => {
			'SEMICOLON' => 9
		},
		GOTOS => {
			'semicolon' => 8
		}
	},
	{#State 3
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'constant_list' => 13,
			'identifier' => 11,
			'constant_definition' => 10
		}
	},
	{#State 4
		ACTIONS => {
			'TYPE' => 15
		},
		DEFAULT => -43,
		GOTOS => {
			'type_definition_part' => 14
		}
	},
	{#State 5
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'identifier' => 16
		}
	},
	{#State 6
		ACTIONS => {
			'' => 17
		}
	},
	{#State 7
		DEFAULT => -1
	},
	{#State 8
		ACTIONS => {
			'LABEL' => 18
		},
		DEFAULT => -11,
		GOTOS => {
			'block' => 20,
			'label_declaration_part' => 19
		}
	},
	{#State 9
		DEFAULT => -252
	},
	{#State 10
		DEFAULT => -18
	},
	{#State 11
		ACTIONS => {
			'EQUAL' => 21
		}
	},
	{#State 12
		DEFAULT => -251
	},
	{#State 13
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		DEFAULT => -15,
		GOTOS => {
			'identifier' => 11,
			'constant_definition' => 22
		}
	},
	{#State 14
		ACTIONS => {
			'VAR' => 23
		},
		DEFAULT => -97,
		GOTOS => {
			'variable_declaration_part' => 24
		}
	},
	{#State 15
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'type_definition_list' => 25,
			'type_definition' => 26,
			'identifier' => 27
		}
	},
	{#State 16
		ACTIONS => {
			'LPAREN' => 28
		},
		DEFAULT => -4
	},
	{#State 17
		DEFAULT => 0
	},
	{#State 18
		ACTIONS => {
			'DIGSEQ' => 30
		},
		GOTOS => {
			'label_list' => 29,
			'label' => 31
		}
	},
	{#State 19
		ACTIONS => {
			'CONST' => 3
		},
		DEFAULT => -16,
		GOTOS => {
			'constant_definition_part' => 32
		}
	},
	{#State 20
		ACTIONS => {
			'DOT' => 33
		}
	},
	{#State 21
		ACTIONS => {
			'DIGSEQ' => 41,
			'PLUS' => 42,
			'IDENTIFIER' => 12,
			'MINUS' => 49,
			'REALNUMBER' => 53,
			'NOT' => 40,
			'NIL' => 38,
			'CHARACTER_STRING' => 36,
			'LPAREN' => 48
		},
		GOTOS => {
			'unsigned_number' => 46,
			'cprimary' => 47,
			'cexpression' => 37,
			'csimple_expression' => 52,
			'identifier' => 51,
			'cterm' => 39,
			'unsigned_real' => 50,
			'cexponentiation' => 34,
			'unsigned_integer' => 43,
			'cfactor' => 44,
			'unsigned_constant' => 45,
			'sign' => 35
		}
	},
	{#State 22
		DEFAULT => -17
	},
	{#State 23
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'variable_declaration_list' => 54,
			'identifier_list' => 56,
			'identifier' => 55,
			'variable_declaration' => 57
		}
	},
	{#State 24
		ACTIONS => {
			'PROCEDURE' => 61,
			'FUNCTION' => 60
		},
		DEFAULT => -102,
		GOTOS => {
			'proc_or_func_declaration' => 62,
			'procedure_and_function_declaration_part' => 58,
			'function_declaration' => 63,
			'proc_or_func_declaration_list' => 64,
			'function_identification' => 59,
			'procedure_heading' => 65,
			'procedure_declaration' => 66,
			'function_heading' => 67,
			'procedure_identification' => 68
		}
	},
	{#State 25
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		DEFAULT => -42,
		GOTOS => {
			'type_definition' => 69,
			'identifier' => 27
		}
	},
	{#State 26
		DEFAULT => -45
	},
	{#State 27
		ACTIONS => {
			'EQUAL' => 70
		}
	},
	{#State 28
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'identifier_list' => 71,
			'identifier' => 55
		}
	},
	{#State 29
		ACTIONS => {
			'SEMICOLON' => 9,
			'COMMA' => 74
		},
		GOTOS => {
			'semicolon' => 73,
			'comma' => 72
		}
	},
	{#State 30
		DEFAULT => -14
	},
	{#State 31
		DEFAULT => -13
	},
	{#State 32
		ACTIONS => {
			'TYPE' => 15
		},
		DEFAULT => -43,
		GOTOS => {
			'type_definition_part' => 75
		}
	},
	{#State 33
		DEFAULT => -3
	},
	{#State 34
		DEFAULT => -27
	},
	{#State 35
		ACTIONS => {
			'IDENTIFIER' => 12,
			'DIGSEQ' => 41,
			'PLUS' => 42,
			'LPAREN' => 48,
			'CHARACTER_STRING' => 36,
			'REALNUMBER' => 53,
			'NOT' => 40,
			'NIL' => 38,
			'MINUS' => 49
		},
		GOTOS => {
			'unsigned_number' => 46,
			'cprimary' => 47,
			'identifier' => 51,
			'unsigned_real' => 50,
			'cexponentiation' => 34,
			'unsigned_integer' => 43,
			'cfactor' => 76,
			'sign' => 35,
			'unsigned_constant' => 45
		}
	},
	{#State 36
		DEFAULT => -223
	},
	{#State 37
		ACTIONS => {
			'SEMICOLON' => 9
		},
		GOTOS => {
			'semicolon' => 77
		}
	},
	{#State 38
		DEFAULT => -224
	},
	{#State 39
		ACTIONS => {
			'DIV' => 81,
			'AND' => 82,
			'SLASH' => 83,
			'MOD' => 79,
			'STAR' => 80
		},
		DEFAULT => -22,
		GOTOS => {
			'mulop' => 78
		}
	},
	{#State 40
		ACTIONS => {
			'LPAREN' => 48,
			'IDENTIFIER' => 12,
			'CHARACTER_STRING' => 36,
			'DIGSEQ' => 41,
			'REALNUMBER' => 53,
			'NOT' => 40,
			'NIL' => 38
		},
		GOTOS => {
			'unsigned_number' => 46,
			'unsigned_integer' => 43,
			'cprimary' => 84,
			'unsigned_constant' => 45,
			'unsigned_real' => 50,
			'identifier' => 51
		}
	},
	{#State 41
		DEFAULT => -227
	},
	{#State 42
		DEFAULT => -37
	},
	{#State 43
		DEFAULT => -225
	},
	{#State 44
		DEFAULT => -24
	},
	{#State 45
		DEFAULT => -32
	},
	{#State 46
		DEFAULT => -222
	},
	{#State 47
		ACTIONS => {
			'STARSTAR' => 85
		},
		DEFAULT => -28
	},
	{#State 48
		ACTIONS => {
			'DIGSEQ' => 41,
			'PLUS' => 42,
			'IDENTIFIER' => 12,
			'MINUS' => 49,
			'REALNUMBER' => 53,
			'NOT' => 40,
			'NIL' => 38,
			'CHARACTER_STRING' => 36,
			'LPAREN' => 48
		},
		GOTOS => {
			'unsigned_number' => 46,
			'cprimary' => 47,
			'cexpression' => 86,
			'identifier' => 51,
			'cterm' => 39,
			'unsigned_real' => 50,
			'csimple_expression' => 52,
			'cexponentiation' => 34,
			'unsigned_integer' => 43,
			'cfactor' => 44,
			'sign' => 35,
			'unsigned_constant' => 45
		}
	},
	{#State 49
		DEFAULT => -38
	},
	{#State 50
		DEFAULT => -226
	},
	{#State 51
		DEFAULT => -30
	},
	{#State 52
		ACTIONS => {
			'LE' => 87,
			'MINUS' => 93,
			'EQUAL' => 96,
			'OR' => 95,
			'LT' => 97,
			'NOTEQUAL' => 91,
			'IN' => 92,
			'PLUS' => 98,
			'GT' => 89,
			'GE' => 90
		},
		DEFAULT => -20,
		GOTOS => {
			'addop' => 94,
			'relop' => 88
		}
	},
	{#State 53
		DEFAULT => -228
	},
	{#State 54
		ACTIONS => {
			'SEMICOLON' => 9
		},
		GOTOS => {
			'semicolon' => 99
		}
	},
	{#State 55
		DEFAULT => -7
	},
	{#State 56
		ACTIONS => {
			'COMMA' => 74,
			'COLON' => 101
		},
		GOTOS => {
			'comma' => 100
		}
	},
	{#State 57
		DEFAULT => -99
	},
	{#State 58
		DEFAULT => -9
	},
	{#State 59
		ACTIONS => {
			'SEMICOLON' => 9
		},
		GOTOS => {
			'semicolon' => 102
		}
	},
	{#State 60
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'identifier' => 103
		}
	},
	{#State 61
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'identifier' => 104
		}
	},
	{#State 62
		DEFAULT => -104
	},
	{#State 63
		DEFAULT => -106
	},
	{#State 64
		ACTIONS => {
			'SEMICOLON' => 9
		},
		GOTOS => {
			'semicolon' => 105
		}
	},
	{#State 65
		ACTIONS => {
			'SEMICOLON' => 9
		},
		GOTOS => {
			'semicolon' => 106
		}
	},
	{#State 66
		DEFAULT => -105
	},
	{#State 67
		ACTIONS => {
			'SEMICOLON' => 9
		},
		GOTOS => {
			'semicolon' => 107
		}
	},
	{#State 68
		ACTIONS => {
			'LPAREN' => 109
		},
		DEFAULT => -109,
		GOTOS => {
			'formal_parameter_list' => 108
		}
	},
	{#State 69
		DEFAULT => -44
	},
	{#State 70
		ACTIONS => {
			'IDENTIFIER' => 12,
			'PLUS' => 42,
			'DIGSEQ' => 117,
			'PFILE' => 134,
			'LPAREN' => 110,
			'ARRAY' => 123,
			'PACKED' => 125,
			'UPARROW' => 124,
			'CHARACTER_STRING' => 127,
			'RECORD' => 128,
			'SET' => 129,
			'REALNUMBER' => 112,
			'MINUS' => 49
		},
		GOTOS => {
			'new_ordinal_type' => 126,
			'structured_type' => 130,
			'non_string' => 132,
			'subrange_type' => 131,
			'set_type' => 135,
			'sign' => 133,
			'identifier' => 111,
			'constant' => 116,
			'new_structured_type' => 118,
			'record_type' => 113,
			'enumerated_type' => 114,
			'file_type' => 115,
			'array_type' => 120,
			'new_pointer_type' => 122,
			'type_denoter' => 121,
			'new_type' => 119
		}
	},
	{#State 71
		ACTIONS => {
			'RPAREN' => 136,
			'COMMA' => 74
		},
		GOTOS => {
			'comma' => 100
		}
	},
	{#State 72
		ACTIONS => {
			'DIGSEQ' => 30
		},
		GOTOS => {
			'label' => 137
		}
	},
	{#State 73
		DEFAULT => -10
	},
	{#State 74
		DEFAULT => -253
	},
	{#State 75
		ACTIONS => {
			'VAR' => 23
		},
		DEFAULT => -97,
		GOTOS => {
			'variable_declaration_part' => 138
		}
	},
	{#State 76
		DEFAULT => -26
	},
	{#State 77
		DEFAULT => -19
	},
	{#State 78
		ACTIONS => {
			'NIL' => 38,
			'NOT' => 40,
			'REALNUMBER' => 53,
			'MINUS' => 49,
			'LPAREN' => 48,
			'CHARACTER_STRING' => 36,
			'IDENTIFIER' => 12,
			'DIGSEQ' => 41,
			'PLUS' => 42
		},
		GOTOS => {
			'cexponentiation' => 34,
			'unsigned_integer' => 43,
			'cfactor' => 139,
			'sign' => 35,
			'unsigned_constant' => 45,
			'unsigned_number' => 46,
			'cprimary' => 47,
			'unsigned_real' => 50,
			'identifier' => 51
		}
	},
	{#State 79
		DEFAULT => -242
	},
	{#State 80
		DEFAULT => -239
	},
	{#State 81
		DEFAULT => -241
	},
	{#State 82
		DEFAULT => -243
	},
	{#State 83
		DEFAULT => -240
	},
	{#State 84
		DEFAULT => -33
	},
	{#State 85
		ACTIONS => {
			'NOT' => 40,
			'REALNUMBER' => 53,
			'NIL' => 38,
			'CHARACTER_STRING' => 36,
			'DIGSEQ' => 41,
			'LPAREN' => 48,
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'unsigned_number' => 46,
			'cexponentiation' => 140,
			'cprimary' => 47,
			'unsigned_integer' => 43,
			'unsigned_constant' => 45,
			'unsigned_real' => 50,
			'identifier' => 51
		}
	},
	{#State 86
		ACTIONS => {
			'RPAREN' => 141
		}
	},
	{#State 87
		DEFAULT => -248
	},
	{#State 88
		ACTIONS => {
			'PLUS' => 42,
			'DIGSEQ' => 41,
			'IDENTIFIER' => 12,
			'MINUS' => 49,
			'REALNUMBER' => 53,
			'NOT' => 40,
			'NIL' => 38,
			'CHARACTER_STRING' => 36,
			'LPAREN' => 48
		},
		GOTOS => {
			'cfactor' => 44,
			'unsigned_constant' => 45,
			'sign' => 35,
			'cexponentiation' => 34,
			'unsigned_integer' => 43,
			'unsigned_real' => 50,
			'cterm' => 39,
			'csimple_expression' => 142,
			'identifier' => 51,
			'unsigned_number' => 46,
			'cprimary' => 47
		}
	},
	{#State 89
		DEFAULT => -247
	},
	{#State 90
		DEFAULT => -249
	},
	{#State 91
		DEFAULT => -245
	},
	{#State 92
		DEFAULT => -250
	},
	{#State 93
		DEFAULT => -237
	},
	{#State 94
		ACTIONS => {
			'NOT' => 40,
			'REALNUMBER' => 53,
			'NIL' => 38,
			'MINUS' => 49,
			'LPAREN' => 48,
			'CHARACTER_STRING' => 36,
			'IDENTIFIER' => 12,
			'DIGSEQ' => 41,
			'PLUS' => 42
		},
		GOTOS => {
			'cfactor' => 44,
			'sign' => 35,
			'unsigned_constant' => 45,
			'cexponentiation' => 34,
			'unsigned_integer' => 43,
			'cterm' => 143,
			'identifier' => 51,
			'unsigned_real' => 50,
			'unsigned_number' => 46,
			'cprimary' => 47
		}
	},
	{#State 95
		DEFAULT => -238
	},
	{#State 96
		DEFAULT => -244
	},
	{#State 97
		DEFAULT => -246
	},
	{#State 98
		DEFAULT => -236
	},
	{#State 99
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		DEFAULT => -96,
		GOTOS => {
			'identifier_list' => 56,
			'identifier' => 55,
			'variable_declaration' => 144
		}
	},
	{#State 100
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'identifier' => 145
		}
	},
	{#State 101
		ACTIONS => {
			'PLUS' => 42,
			'DIGSEQ' => 117,
			'IDENTIFIER' => 12,
			'PFILE' => 134,
			'CHARACTER_STRING' => 127,
			'PACKED' => 125,
			'UPARROW' => 124,
			'LPAREN' => 110,
			'ARRAY' => 123,
			'MINUS' => 49,
			'REALNUMBER' => 112,
			'RECORD' => 128,
			'SET' => 129
		},
		GOTOS => {
			'identifier' => 111,
			'new_type' => 119,
			'new_pointer_type' => 122,
			'type_denoter' => 146,
			'array_type' => 120,
			'file_type' => 115,
			'record_type' => 113,
			'enumerated_type' => 114,
			'new_structured_type' => 118,
			'constant' => 116,
			'structured_type' => 130,
			'new_ordinal_type' => 126,
			'sign' => 133,
			'set_type' => 135,
			'subrange_type' => 131,
			'non_string' => 132
		}
	},
	{#State 102
		ACTIONS => {
			'LABEL' => 18
		},
		DEFAULT => -11,
		GOTOS => {
			'label_declaration_part' => 19,
			'function_block' => 148,
			'block' => 147
		}
	},
	{#State 103
		ACTIONS => {
			'COLON' => 150,
			'LPAREN' => 109
		},
		DEFAULT => -132,
		GOTOS => {
			'formal_parameter_list' => 149
		}
	},
	{#State 104
		DEFAULT => -124
	},
	{#State 105
		ACTIONS => {
			'PROCEDURE' => 61,
			'FUNCTION' => 60
		},
		DEFAULT => -101,
		GOTOS => {
			'function_identification' => 59,
			'procedure_identification' => 68,
			'function_heading' => 67,
			'function_declaration' => 63,
			'proc_or_func_declaration' => 151,
			'procedure_heading' => 65,
			'procedure_declaration' => 66
		}
	},
	{#State 106
		ACTIONS => {
			'EXTERNAL' => 153,
			'LABEL' => 18,
			'FORWARD' => 155
		},
		DEFAULT => -11,
		GOTOS => {
			'directive' => 154,
			'label_declaration_part' => 19,
			'procedure_block' => 152,
			'block' => 156
		}
	},
	{#State 107
		ACTIONS => {
			'EXTERNAL' => 153,
			'FORWARD' => 155,
			'LABEL' => 18
		},
		DEFAULT => -11,
		GOTOS => {
			'block' => 147,
			'function_block' => 158,
			'directive' => 157,
			'label_declaration_part' => 19
		}
	},
	{#State 108
		DEFAULT => -110
	},
	{#State 109
		ACTIONS => {
			'PROCEDURE' => 61,
			'VAR' => 162,
			'FUNCTION' => 169,
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'variable_parameter_specification' => 163,
			'procedure_identification' => 68,
			'functional_parameter_specification' => 168,
			'procedure_heading' => 164,
			'function_heading' => 166,
			'formal_parameter_section' => 165,
			'procedural_parameter_specification' => 160,
			'value_parameter_specification' => 159,
			'identifier_list' => 167,
			'identifier' => 55,
			'formal_parameter_section_list' => 161
		}
	},
	{#State 110
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'identifier_list' => 170,
			'identifier' => 55
		}
	},
	{#State 111
		ACTIONS => {
			'DOTDOT' => -40
		},
		DEFAULT => -47
	},
	{#State 112
		DEFAULT => -41
	},
	{#State 113
		DEFAULT => -59
	},
	{#State 114
		DEFAULT => -52
	},
	{#State 115
		DEFAULT => -61
	},
	{#State 116
		ACTIONS => {
			'DOTDOT' => 171
		}
	},
	{#State 117
		DEFAULT => -39
	},
	{#State 118
		DEFAULT => -50
	},
	{#State 119
		DEFAULT => -48
	},
	{#State 120
		DEFAULT => -58
	},
	{#State 121
		ACTIONS => {
			'SEMICOLON' => 9
		},
		GOTOS => {
			'semicolon' => 172
		}
	},
	{#State 122
		DEFAULT => -51
	},
	{#State 123
		ACTIONS => {
			'LBRAC' => 173
		}
	},
	{#State 124
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'domain_type' => 174,
			'identifier' => 175
		}
	},
	{#State 125
		ACTIONS => {
			'PFILE' => 134,
			'SET' => 129,
			'RECORD' => 128,
			'ARRAY' => 123
		},
		GOTOS => {
			'set_type' => 135,
			'array_type' => 120,
			'structured_type' => 176,
			'file_type' => 115,
			'record_type' => 113
		}
	},
	{#State 126
		DEFAULT => -49
	},
	{#State 127
		DEFAULT => -36
	},
	{#State 128
		ACTIONS => {
			'IDENTIFIER' => 12,
			'CASE' => 179
		},
		DEFAULT => -77,
		GOTOS => {
			'record_section' => 178,
			'variant_part' => 181,
			'record_section_list' => 177,
			'identifier_list' => 180,
			'identifier' => 55
		}
	},
	{#State 129
		ACTIONS => {
			'OF' => 182
		}
	},
	{#State 130
		DEFAULT => -56
	},
	{#State 131
		DEFAULT => -53
	},
	{#State 132
		DEFAULT => -34
	},
	{#State 133
		ACTIONS => {
			'DIGSEQ' => 117,
			'IDENTIFIER' => 12,
			'REALNUMBER' => 112
		},
		GOTOS => {
			'identifier' => 184,
			'non_string' => 183
		}
	},
	{#State 134
		ACTIONS => {
			'OF' => 185
		}
	},
	{#State 135
		DEFAULT => -60
	},
	{#State 136
		DEFAULT => -5
	},
	{#State 137
		DEFAULT => -12
	},
	{#State 138
		ACTIONS => {
			'FUNCTION' => 60,
			'PROCEDURE' => 61
		},
		DEFAULT => -102,
		GOTOS => {
			'function_heading' => 67,
			'procedure_heading' => 65,
			'procedure_declaration' => 66,
			'procedure_identification' => 68,
			'function_declaration' => 63,
			'proc_or_func_declaration' => 62,
			'procedure_and_function_declaration_part' => 186,
			'proc_or_func_declaration_list' => 64,
			'function_identification' => 59
		}
	},
	{#State 139
		DEFAULT => -25
	},
	{#State 140
		DEFAULT => -29
	},
	{#State 141
		DEFAULT => -31
	},
	{#State 142
		ACTIONS => {
			'OR' => 95,
			'PLUS' => 98,
			'MINUS' => 93
		},
		DEFAULT => -21,
		GOTOS => {
			'addop' => 94
		}
	},
	{#State 143
		ACTIONS => {
			'SLASH' => 83,
			'AND' => 82,
			'DIV' => 81,
			'STAR' => 80,
			'MOD' => 79
		},
		DEFAULT => -23,
		GOTOS => {
			'mulop' => 78
		}
	},
	{#State 144
		DEFAULT => -98
	},
	{#State 145
		DEFAULT => -6
	},
	{#State 146
		DEFAULT => -100
	},
	{#State 147
		DEFAULT => -133
	},
	{#State 148
		DEFAULT => -127
	},
	{#State 149
		ACTIONS => {
			'COLON' => 187
		}
	},
	{#State 150
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'result_type' => 188,
			'identifier' => 189
		}
	},
	{#State 151
		DEFAULT => -103
	},
	{#State 152
		DEFAULT => -108
	},
	{#State 153
		DEFAULT => -112
	},
	{#State 154
		DEFAULT => -107
	},
	{#State 155
		DEFAULT => -111
	},
	{#State 156
		DEFAULT => -125
	},
	{#State 157
		DEFAULT => -126
	},
	{#State 158
		DEFAULT => -128
	},
	{#State 159
		DEFAULT => -116
	},
	{#State 160
		DEFAULT => -118
	},
	{#State 161
		ACTIONS => {
			'RPAREN' => 191,
			'SEMICOLON' => 9
		},
		GOTOS => {
			'semicolon' => 190
		}
	},
	{#State 162
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'identifier_list' => 192,
			'identifier' => 55
		}
	},
	{#State 163
		DEFAULT => -117
	},
	{#State 164
		DEFAULT => -122
	},
	{#State 165
		DEFAULT => -115
	},
	{#State 166
		DEFAULT => -123
	},
	{#State 167
		ACTIONS => {
			'COLON' => 193,
			'COMMA' => 74
		},
		GOTOS => {
			'comma' => 100
		}
	},
	{#State 168
		DEFAULT => -119
	},
	{#State 169
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'identifier' => 194
		}
	},
	{#State 170
		ACTIONS => {
			'RPAREN' => 195,
			'COMMA' => 74
		},
		GOTOS => {
			'comma' => 100
		}
	},
	{#State 171
		ACTIONS => {
			'REALNUMBER' => 112,
			'MINUS' => 49,
			'IDENTIFIER' => 12,
			'DIGSEQ' => 117,
			'PLUS' => 42,
			'CHARACTER_STRING' => 127
		},
		GOTOS => {
			'constant' => 196,
			'non_string' => 132,
			'sign' => 133,
			'identifier' => 184
		}
	},
	{#State 172
		DEFAULT => -46
	},
	{#State 173
		ACTIONS => {
			'PLUS' => 42,
			'DIGSEQ' => 117,
			'CHARACTER_STRING' => 127,
			'IDENTIFIER' => 12,
			'LPAREN' => 110,
			'MINUS' => 49,
			'REALNUMBER' => 112
		},
		GOTOS => {
			'index_type' => 200,
			'identifier' => 198,
			'index_list' => 197,
			'new_ordinal_type' => 199,
			'sign' => 133,
			'ordinal_type' => 201,
			'subrange_type' => 131,
			'enumerated_type' => 114,
			'non_string' => 132,
			'constant' => 116
		}
	},
	{#State 174
		DEFAULT => -94
	},
	{#State 175
		DEFAULT => -95
	},
	{#State 176
		DEFAULT => -57
	},
	{#State 177
		ACTIONS => {
			'SEMICOLON' => 9,
			'END' => 202
		},
		GOTOS => {
			'semicolon' => 203
		}
	},
	{#State 178
		DEFAULT => -73
	},
	{#State 179
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'identifier' => 205,
			'tag_field' => 207,
			'tag_type' => 204,
			'variant_selector' => 206
		}
	},
	{#State 180
		ACTIONS => {
			'COLON' => 208,
			'COMMA' => 74
		},
		GOTOS => {
			'comma' => 100
		}
	},
	{#State 181
		ACTIONS => {
			'END' => 209
		}
	},
	{#State 182
		ACTIONS => {
			'LPAREN' => 110,
			'IDENTIFIER' => 12,
			'CHARACTER_STRING' => 127,
			'PLUS' => 42,
			'DIGSEQ' => 117,
			'REALNUMBER' => 112,
			'MINUS' => 49
		},
		GOTOS => {
			'sign' => 133,
			'enumerated_type' => 114,
			'ordinal_type' => 210,
			'subrange_type' => 131,
			'constant' => 116,
			'non_string' => 132,
			'identifier' => 198,
			'new_ordinal_type' => 199,
			'base_type' => 211
		}
	},
	{#State 183
		DEFAULT => -35
	},
	{#State 184
		DEFAULT => -40
	},
	{#State 185
		ACTIONS => {
			'DIGSEQ' => 117,
			'PLUS' => 42,
			'IDENTIFIER' => 12,
			'PFILE' => 134,
			'PACKED' => 125,
			'UPARROW' => 124,
			'CHARACTER_STRING' => 127,
			'ARRAY' => 123,
			'LPAREN' => 110,
			'MINUS' => 49,
			'SET' => 129,
			'RECORD' => 128,
			'REALNUMBER' => 112
		},
		GOTOS => {
			'structured_type' => 130,
			'component_type' => 213,
			'new_ordinal_type' => 126,
			'sign' => 133,
			'set_type' => 135,
			'subrange_type' => 131,
			'non_string' => 132,
			'identifier' => 111,
			'new_type' => 119,
			'new_pointer_type' => 122,
			'type_denoter' => 212,
			'array_type' => 120,
			'file_type' => 115,
			'record_type' => 113,
			'enumerated_type' => 114,
			'new_structured_type' => 118,
			'constant' => 116
		}
	},
	{#State 186
		ACTIONS => {
			'PBEGIN' => 214
		},
		GOTOS => {
			'compound_statement' => 216,
			'statement_part' => 215
		}
	},
	{#State 187
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'identifier' => 189,
			'result_type' => 217
		}
	},
	{#State 188
		DEFAULT => -129
	},
	{#State 189
		DEFAULT => -131
	},
	{#State 190
		ACTIONS => {
			'FUNCTION' => 169,
			'VAR' => 162,
			'PROCEDURE' => 61,
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'functional_parameter_specification' => 168,
			'procedure_heading' => 164,
			'formal_parameter_section' => 218,
			'function_heading' => 166,
			'procedure_identification' => 68,
			'variable_parameter_specification' => 163,
			'identifier' => 55,
			'identifier_list' => 167,
			'value_parameter_specification' => 159,
			'procedural_parameter_specification' => 160
		}
	},
	{#State 191
		DEFAULT => -113
	},
	{#State 192
		ACTIONS => {
			'COMMA' => 74,
			'COLON' => 219
		},
		GOTOS => {
			'comma' => 100
		}
	},
	{#State 193
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'identifier' => 220
		}
	},
	{#State 194
		ACTIONS => {
			'LPAREN' => 109,
			'COLON' => 150
		},
		GOTOS => {
			'formal_parameter_list' => 149
		}
	},
	{#State 195
		DEFAULT => -54
	},
	{#State 196
		DEFAULT => -55
	},
	{#State 197
		ACTIONS => {
			'COMMA' => 74,
			'RBRAC' => 222
		},
		GOTOS => {
			'comma' => 221
		}
	},
	{#State 198
		ACTIONS => {
			'DOTDOT' => -40
		},
		DEFAULT => -67
	},
	{#State 199
		DEFAULT => -66
	},
	{#State 200
		DEFAULT => -64
	},
	{#State 201
		DEFAULT => -65
	},
	{#State 202
		DEFAULT => -69
	},
	{#State 203
		ACTIONS => {
			'CASE' => 179,
			'IDENTIFIER' => 12
		},
		DEFAULT => -77,
		GOTOS => {
			'record_section' => 224,
			'variant_part' => 223,
			'identifier_list' => 180,
			'identifier' => 55
		}
	},
	{#State 204
		DEFAULT => -79
	},
	{#State 205
		ACTIONS => {
			'OF' => -90
		},
		DEFAULT => -89
	},
	{#State 206
		ACTIONS => {
			'OF' => 225
		}
	},
	{#State 207
		ACTIONS => {
			'COLON' => 226
		}
	},
	{#State 208
		ACTIONS => {
			'PFILE' => 134,
			'IDENTIFIER' => 12,
			'PLUS' => 42,
			'DIGSEQ' => 117,
			'RECORD' => 128,
			'SET' => 129,
			'REALNUMBER' => 112,
			'MINUS' => 49,
			'ARRAY' => 123,
			'LPAREN' => 110,
			'UPARROW' => 124,
			'PACKED' => 125,
			'CHARACTER_STRING' => 127
		},
		GOTOS => {
			'identifier' => 111,
			'new_type' => 119,
			'new_pointer_type' => 122,
			'type_denoter' => 227,
			'array_type' => 120,
			'file_type' => 115,
			'record_type' => 113,
			'enumerated_type' => 114,
			'new_structured_type' => 118,
			'constant' => 116,
			'structured_type' => 130,
			'new_ordinal_type' => 126,
			'sign' => 133,
			'set_type' => 135,
			'subrange_type' => 131,
			'non_string' => 132
		}
	},
	{#State 209
		DEFAULT => -71
	},
	{#State 210
		DEFAULT => -92
	},
	{#State 211
		DEFAULT => -91
	},
	{#State 212
		DEFAULT => -68
	},
	{#State 213
		DEFAULT => -93
	},
	{#State 214
		ACTIONS => {
			'DIGSEQ' => 30,
			'WHILE' => 254,
			'GOTO' => 253,
			'IDENTIFIER' => 12,
			'PBEGIN' => 214,
			'REPEAT' => 231,
			'FOR' => 259,
			'CASE' => 242,
			'WITH' => 248,
			'IF' => 233
		},
		DEFAULT => -154,
		GOTOS => {
			'repeat_statement' => 246,
			'procedure_statement' => 230,
			'non_labeled_open_statement' => 229,
			'goto_statement' => 228,
			'non_labeled_closed_statement' => 232,
			'variable_access' => 250,
			'closed_while_statement' => 251,
			'closed_for_statement' => 234,
			'assignment_statement' => 249,
			'open_with_statement' => 247,
			'open_while_statement' => 240,
			'field_designator' => 239,
			'statement_sequence' => 241,
			'closed_if_statement' => 252,
			'closed_statement' => 235,
			'closed_with_statement' => 236,
			'open_statement' => 237,
			'compound_statement' => 238,
			'open_if_statement' => 244,
			'statement' => 258,
			'open_for_statement' => 257,
			'label' => 245,
			'identifier' => 255,
			'case_statement' => 256,
			'indexed_variable' => 243
		}
	},
	{#State 215
		DEFAULT => -8
	},
	{#State 216
		DEFAULT => -134
	},
	{#State 217
		DEFAULT => -130
	},
	{#State 218
		DEFAULT => -114
	},
	{#State 219
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'identifier' => 260
		}
	},
	{#State 220
		DEFAULT => -120
	},
	{#State 221
		ACTIONS => {
			'MINUS' => 49,
			'REALNUMBER' => 112,
			'PLUS' => 42,
			'DIGSEQ' => 117,
			'CHARACTER_STRING' => 127,
			'IDENTIFIER' => 12,
			'LPAREN' => 110
		},
		GOTOS => {
			'sign' => 133,
			'enumerated_type' => 114,
			'subrange_type' => 131,
			'ordinal_type' => 201,
			'constant' => 116,
			'non_string' => 132,
			'identifier' => 198,
			'index_type' => 261,
			'new_ordinal_type' => 199
		}
	},
	{#State 222
		ACTIONS => {
			'OF' => 262
		}
	},
	{#State 223
		ACTIONS => {
			'END' => 263
		}
	},
	{#State 224
		DEFAULT => -72
	},
	{#State 225
		ACTIONS => {
			'REALNUMBER' => 112,
			'MINUS' => 49,
			'IDENTIFIER' => 12,
			'PLUS' => 42,
			'DIGSEQ' => 117,
			'CHARACTER_STRING' => 127
		},
		GOTOS => {
			'variant_list' => 268,
			'identifier' => 184,
			'case_constant' => 266,
			'constant' => 264,
			'non_string' => 132,
			'sign' => 133,
			'case_constant_list' => 265,
			'variant' => 267
		}
	},
	{#State 226
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'tag_type' => 270,
			'identifier' => 269
		}
	},
	{#State 227
		DEFAULT => -74
	},
	{#State 228
		DEFAULT => -146
	},
	{#State 229
		DEFAULT => -141
	},
	{#State 230
		DEFAULT => -145
	},
	{#State 231
		ACTIONS => {
			'PBEGIN' => 214,
			'REPEAT' => 231,
			'GOTO' => 253,
			'WHILE' => 254,
			'DIGSEQ' => 30,
			'IDENTIFIER' => 12,
			'WITH' => 248,
			'CASE' => 242,
			'IF' => 233,
			'FOR' => 259
		},
		DEFAULT => -154,
		GOTOS => {
			'repeat_statement' => 246,
			'non_labeled_open_statement' => 229,
			'goto_statement' => 228,
			'procedure_statement' => 230,
			'non_labeled_closed_statement' => 232,
			'variable_access' => 250,
			'closed_while_statement' => 251,
			'closed_for_statement' => 234,
			'open_with_statement' => 247,
			'assignment_statement' => 249,
			'open_while_statement' => 240,
			'field_designator' => 239,
			'statement_sequence' => 271,
			'closed_if_statement' => 252,
			'closed_statement' => 235,
			'closed_with_statement' => 236,
			'compound_statement' => 238,
			'open_statement' => 237,
			'statement' => 258,
			'open_for_statement' => 257,
			'open_if_statement' => 244,
			'label' => 245,
			'identifier' => 255,
			'case_statement' => 256,
			'indexed_variable' => 243
		}
	},
	{#State 232
		DEFAULT => -143
	},
	{#State 233
		ACTIONS => {
			'IDENTIFIER' => 12,
			'PLUS' => 42,
			'DIGSEQ' => 41,
			'NIL' => 38,
			'NOT' => 286,
			'REALNUMBER' => 53,
			'MINUS' => 49,
			'LPAREN' => 276,
			'LBRAC' => 275,
			'CHARACTER_STRING' => 36
		},
		GOTOS => {
			'expression' => 285,
			'sign' => 284,
			'boolean_expression' => 283,
			'variable_access' => 287,
			'primary' => 277,
			'field_designator' => 239,
			'term' => 274,
			'unsigned_integer' => 43,
			'set_constructor' => 273,
			'factor' => 272,
			'exponentiation' => 279,
			'unsigned_constant' => 278,
			'function_designator' => 281,
			'unsigned_number' => 46,
			'simple_expression' => 282,
			'unsigned_real' => 50,
			'identifier' => 280,
			'indexed_variable' => 243
		}
	},
	{#State 234
		DEFAULT => -153
	},
	{#State 235
		DEFAULT => -139
	},
	{#State 236
		DEFAULT => -150
	},
	{#State 237
		DEFAULT => -138
	},
	{#State 238
		DEFAULT => -147
	},
	{#State 239
		DEFAULT => -172
	},
	{#State 240
		DEFAULT => -157
	},
	{#State 241
		ACTIONS => {
			'SEMICOLON' => 9,
			'END' => 288
		},
		GOTOS => {
			'semicolon' => 289
		}
	},
	{#State 242
		ACTIONS => {
			'CHARACTER_STRING' => 36,
			'LBRAC' => 275,
			'LPAREN' => 276,
			'MINUS' => 49,
			'NOT' => 286,
			'REALNUMBER' => 53,
			'NIL' => 38,
			'DIGSEQ' => 41,
			'PLUS' => 42,
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'expression' => 290,
			'sign' => 284,
			'case_index' => 291,
			'primary' => 277,
			'variable_access' => 287,
			'exponentiation' => 279,
			'factor' => 272,
			'set_constructor' => 273,
			'term' => 274,
			'field_designator' => 239,
			'unsigned_integer' => 43,
			'unsigned_constant' => 278,
			'unsigned_number' => 46,
			'function_designator' => 281,
			'simple_expression' => 282,
			'indexed_variable' => 243,
			'unsigned_real' => 50,
			'identifier' => 280
		}
	},
	{#State 243
		DEFAULT => -171
	},
	{#State 244
		DEFAULT => -156
	},
	{#State 245
		ACTIONS => {
			'COLON' => 292
		}
	},
	{#State 246
		DEFAULT => -149
	},
	{#State 247
		DEFAULT => -155
	},
	{#State 248
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'variable_access' => 293,
			'field_designator' => 239,
			'record_variable_list' => 295,
			'indexed_variable' => 243,
			'identifier' => 294
		}
	},
	{#State 249
		DEFAULT => -144
	},
	{#State 250
		ACTIONS => {
			'DOT' => 298,
			'UPARROW' => 299,
			'LBRAC' => 297,
			'ASSIGNMENT' => 296
		}
	},
	{#State 251
		DEFAULT => -152
	},
	{#State 252
		DEFAULT => -151
	},
	{#State 253
		ACTIONS => {
			'DIGSEQ' => 30
		},
		GOTOS => {
			'label' => 300
		}
	},
	{#State 254
		ACTIONS => {
			'IDENTIFIER' => 12,
			'DIGSEQ' => 41,
			'PLUS' => 42,
			'NOT' => 286,
			'REALNUMBER' => 53,
			'NIL' => 38,
			'MINUS' => 49,
			'LPAREN' => 276,
			'CHARACTER_STRING' => 36,
			'LBRAC' => 275
		},
		GOTOS => {
			'variable_access' => 287,
			'primary' => 277,
			'expression' => 285,
			'sign' => 284,
			'boolean_expression' => 301,
			'simple_expression' => 282,
			'function_designator' => 281,
			'unsigned_number' => 46,
			'unsigned_real' => 50,
			'identifier' => 280,
			'indexed_variable' => 243,
			'unsigned_integer' => 43,
			'term' => 274,
			'field_designator' => 239,
			'set_constructor' => 273,
			'exponentiation' => 279,
			'factor' => 272,
			'unsigned_constant' => 278
		}
	},
	{#State 255
		ACTIONS => {
			'UNTIL' => -180,
			'SEMICOLON' => -180,
			'LPAREN' => 302,
			'END' => -180,
			'ELSE' => -180
		},
		DEFAULT => -170,
		GOTOS => {
			'params' => 303
		}
	},
	{#State 256
		DEFAULT => -148
	},
	{#State 257
		DEFAULT => -158
	},
	{#State 258
		DEFAULT => -137
	},
	{#State 259
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'control_variable' => 304,
			'identifier' => 305
		}
	},
	{#State 260
		DEFAULT => -121
	},
	{#State 261
		DEFAULT => -63
	},
	{#State 262
		ACTIONS => {
			'MINUS' => 49,
			'REALNUMBER' => 112,
			'RECORD' => 128,
			'SET' => 129,
			'CHARACTER_STRING' => 127,
			'UPARROW' => 124,
			'PACKED' => 125,
			'ARRAY' => 123,
			'LPAREN' => 110,
			'PFILE' => 134,
			'DIGSEQ' => 117,
			'PLUS' => 42,
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'sign' => 133,
			'set_type' => 135,
			'subrange_type' => 131,
			'non_string' => 132,
			'structured_type' => 130,
			'component_type' => 306,
			'new_ordinal_type' => 126,
			'new_type' => 119,
			'new_pointer_type' => 122,
			'type_denoter' => 212,
			'array_type' => 120,
			'file_type' => 115,
			'record_type' => 113,
			'enumerated_type' => 114,
			'new_structured_type' => 118,
			'constant' => 116,
			'identifier' => 111
		}
	},
	{#State 263
		DEFAULT => -70
	},
	{#State 264
		ACTIONS => {
			'DOTDOT' => 307
		},
		DEFAULT => -87
	},
	{#State 265
		ACTIONS => {
			'COMMA' => 74,
			'COLON' => 309
		},
		GOTOS => {
			'comma' => 308
		}
	},
	{#State 266
		DEFAULT => -86
	},
	{#State 267
		DEFAULT => -81
	},
	{#State 268
		ACTIONS => {
			'SEMICOLON' => 9
		},
		DEFAULT => -76,
		GOTOS => {
			'semicolon' => 310
		}
	},
	{#State 269
		DEFAULT => -90
	},
	{#State 270
		DEFAULT => -78
	},
	{#State 271
		ACTIONS => {
			'UNTIL' => 311,
			'SEMICOLON' => 9
		},
		GOTOS => {
			'semicolon' => 289
		}
	},
	{#State 272
		DEFAULT => -210
	},
	{#State 273
		DEFAULT => -219
	},
	{#State 274
		ACTIONS => {
			'SLASH' => 83,
			'AND' => 82,
			'DIV' => 81,
			'STAR' => 80,
			'MOD' => 79
		},
		DEFAULT => -208,
		GOTOS => {
			'mulop' => 312
		}
	},
	{#State 275
		ACTIONS => {
			'IDENTIFIER' => 12,
			'DIGSEQ' => 41,
			'RBRAC' => 316,
			'PLUS' => 42,
			'LPAREN' => 276,
			'LBRAC' => 275,
			'CHARACTER_STRING' => 36,
			'NIL' => 38,
			'REALNUMBER' => 53,
			'NOT' => 286,
			'MINUS' => 49
		},
		GOTOS => {
			'primary' => 277,
			'variable_access' => 287,
			'expression' => 313,
			'member_designator' => 314,
			'sign' => 284,
			'simple_expression' => 282,
			'unsigned_number' => 46,
			'function_designator' => 281,
			'indexed_variable' => 243,
			'unsigned_real' => 50,
			'identifier' => 280,
			'exponentiation' => 279,
			'set_constructor' => 273,
			'factor' => 272,
			'unsigned_integer' => 43,
			'term' => 274,
			'field_designator' => 239,
			'member_designator_list' => 315,
			'unsigned_constant' => 278
		}
	},
	{#State 276
		ACTIONS => {
			'IDENTIFIER' => 12,
			'PLUS' => 42,
			'DIGSEQ' => 41,
			'LPAREN' => 276,
			'CHARACTER_STRING' => 36,
			'LBRAC' => 275,
			'NOT' => 286,
			'REALNUMBER' => 53,
			'NIL' => 38,
			'MINUS' => 49
		},
		GOTOS => {
			'unsigned_constant' => 278,
			'set_constructor' => 273,
			'exponentiation' => 279,
			'factor' => 272,
			'term' => 274,
			'field_designator' => 239,
			'unsigned_integer' => 43,
			'indexed_variable' => 243,
			'unsigned_real' => 50,
			'identifier' => 280,
			'unsigned_number' => 46,
			'function_designator' => 281,
			'simple_expression' => 282,
			'sign' => 284,
			'expression' => 317,
			'primary' => 277,
			'variable_access' => 287
		}
	},
	{#State 277
		ACTIONS => {
			'STARSTAR' => 318
		},
		DEFAULT => -214
	},
	{#State 278
		DEFAULT => -217
	},
	{#State 279
		DEFAULT => -213
	},
	{#State 280
		ACTIONS => {
			'LPAREN' => 302
		},
		DEFAULT => -170,
		GOTOS => {
			'params' => 319
		}
	},
	{#State 281
		DEFAULT => -218
	},
	{#State 282
		ACTIONS => {
			'LT' => 97,
			'PLUS' => 98,
			'MINUS' => 93,
			'EQUAL' => 96,
			'OR' => 95,
			'NOTEQUAL' => 91,
			'IN' => 92,
			'GT' => 89,
			'GE' => 90,
			'LE' => 87
		},
		DEFAULT => -206,
		GOTOS => {
			'addop' => 320,
			'relop' => 321
		}
	},
	{#State 283
		ACTIONS => {
			'THEN' => 322
		}
	},
	{#State 284
		ACTIONS => {
			'MINUS' => 49,
			'NIL' => 38,
			'NOT' => 286,
			'REALNUMBER' => 53,
			'LBRAC' => 275,
			'CHARACTER_STRING' => 36,
			'LPAREN' => 276,
			'PLUS' => 42,
			'DIGSEQ' => 41,
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'primary' => 277,
			'function_designator' => 281,
			'unsigned_number' => 46,
			'variable_access' => 287,
			'indexed_variable' => 243,
			'unsigned_real' => 50,
			'identifier' => 280,
			'set_constructor' => 273,
			'exponentiation' => 279,
			'factor' => 323,
			'unsigned_integer' => 43,
			'field_designator' => 239,
			'sign' => 284,
			'unsigned_constant' => 278
		}
	},
	{#State 285
		DEFAULT => -205
	},
	{#State 286
		ACTIONS => {
			'NIL' => 38,
			'NOT' => 286,
			'REALNUMBER' => 53,
			'LPAREN' => 276,
			'LBRAC' => 275,
			'CHARACTER_STRING' => 36,
			'IDENTIFIER' => 12,
			'DIGSEQ' => 41
		},
		GOTOS => {
			'primary' => 324,
			'unsigned_number' => 46,
			'function_designator' => 281,
			'variable_access' => 287,
			'indexed_variable' => 243,
			'identifier' => 280,
			'unsigned_real' => 50,
			'set_constructor' => 273,
			'unsigned_integer' => 43,
			'field_designator' => 239,
			'unsigned_constant' => 278
		}
	},
	{#State 287
		ACTIONS => {
			'LBRAC' => 297,
			'UPARROW' => 299,
			'DOT' => 298
		},
		DEFAULT => -216
	},
	{#State 288
		DEFAULT => -135
	},
	{#State 289
		ACTIONS => {
			'FOR' => 259,
			'CASE' => 242,
			'WITH' => 248,
			'IF' => 233,
			'WHILE' => 254,
			'GOTO' => 253,
			'DIGSEQ' => 30,
			'IDENTIFIER' => 12,
			'PBEGIN' => 214,
			'REPEAT' => 231
		},
		DEFAULT => -154,
		GOTOS => {
			'open_for_statement' => 257,
			'statement' => 325,
			'open_if_statement' => 244,
			'label' => 245,
			'indexed_variable' => 243,
			'identifier' => 255,
			'case_statement' => 256,
			'open_while_statement' => 240,
			'field_designator' => 239,
			'closed_with_statement' => 236,
			'open_statement' => 237,
			'compound_statement' => 238,
			'closed_if_statement' => 252,
			'closed_statement' => 235,
			'variable_access' => 250,
			'closed_while_statement' => 251,
			'open_with_statement' => 247,
			'assignment_statement' => 249,
			'closed_for_statement' => 234,
			'repeat_statement' => 246,
			'non_labeled_closed_statement' => 232,
			'non_labeled_open_statement' => 229,
			'procedure_statement' => 230,
			'goto_statement' => 228
		}
	},
	{#State 290
		DEFAULT => -192
	},
	{#State 291
		ACTIONS => {
			'OF' => 326
		}
	},
	{#State 292
		ACTIONS => {
			'CASE' => 242,
			'WITH' => 248,
			'IF' => 233,
			'FOR' => 259,
			'PBEGIN' => 214,
			'REPEAT' => 231,
			'GOTO' => 253,
			'WHILE' => 254,
			'IDENTIFIER' => 12
		},
		DEFAULT => -154,
		GOTOS => {
			'open_for_statement' => 257,
			'open_if_statement' => 244,
			'indexed_variable' => 243,
			'case_statement' => 256,
			'identifier' => 255,
			'open_while_statement' => 240,
			'field_designator' => 239,
			'closed_with_statement' => 236,
			'compound_statement' => 238,
			'closed_if_statement' => 252,
			'closed_while_statement' => 251,
			'variable_access' => 250,
			'open_with_statement' => 247,
			'assignment_statement' => 249,
			'closed_for_statement' => 234,
			'repeat_statement' => 246,
			'non_labeled_closed_statement' => 327,
			'non_labeled_open_statement' => 328,
			'procedure_statement' => 230,
			'goto_statement' => 228
		}
	},
	{#State 293
		ACTIONS => {
			'UPARROW' => 299,
			'LBRAC' => 297,
			'DOT' => 298
		},
		DEFAULT => -204
	},
	{#State 294
		DEFAULT => -170
	},
	{#State 295
		ACTIONS => {
			'COMMA' => 74,
			'DO' => 330
		},
		GOTOS => {
			'comma' => 329
		}
	},
	{#State 296
		ACTIONS => {
			'IDENTIFIER' => 12,
			'PLUS' => 42,
			'DIGSEQ' => 41,
			'NIL' => 38,
			'REALNUMBER' => 53,
			'NOT' => 286,
			'MINUS' => 49,
			'LPAREN' => 276,
			'LBRAC' => 275,
			'CHARACTER_STRING' => 36
		},
		GOTOS => {
			'function_designator' => 281,
			'unsigned_number' => 46,
			'simple_expression' => 282,
			'identifier' => 280,
			'unsigned_real' => 50,
			'indexed_variable' => 243,
			'term' => 274,
			'field_designator' => 239,
			'unsigned_integer' => 43,
			'set_constructor' => 273,
			'factor' => 272,
			'exponentiation' => 279,
			'unsigned_constant' => 278,
			'variable_access' => 287,
			'primary' => 277,
			'expression' => 331,
			'sign' => 284
		}
	},
	{#State 297
		ACTIONS => {
			'IDENTIFIER' => 12,
			'PLUS' => 42,
			'DIGSEQ' => 41,
			'LPAREN' => 276,
			'CHARACTER_STRING' => 36,
			'LBRAC' => 275,
			'REALNUMBER' => 53,
			'NOT' => 286,
			'NIL' => 38,
			'MINUS' => 49
		},
		GOTOS => {
			'unsigned_number' => 46,
			'function_designator' => 281,
			'simple_expression' => 282,
			'index_expression_list' => 333,
			'identifier' => 280,
			'unsigned_real' => 50,
			'indexed_variable' => 243,
			'term' => 274,
			'field_designator' => 239,
			'unsigned_integer' => 43,
			'set_constructor' => 273,
			'factor' => 272,
			'exponentiation' => 279,
			'unsigned_constant' => 278,
			'variable_access' => 287,
			'index_expression' => 332,
			'primary' => 277,
			'expression' => 334,
			'sign' => 284
		}
	},
	{#State 298
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'identifier' => 335
		}
	},
	{#State 299
		DEFAULT => -173
	},
	{#State 300
		DEFAULT => -187
	},
	{#State 301
		ACTIONS => {
			'DO' => 336
		}
	},
	{#State 302
		ACTIONS => {
			'DIGSEQ' => 41,
			'PLUS' => 42,
			'IDENTIFIER' => 12,
			'MINUS' => 49,
			'NOT' => 286,
			'REALNUMBER' => 53,
			'NIL' => 38,
			'CHARACTER_STRING' => 36,
			'LBRAC' => 275,
			'LPAREN' => 276
		},
		GOTOS => {
			'simple_expression' => 282,
			'unsigned_number' => 46,
			'function_designator' => 281,
			'indexed_variable' => 243,
			'actual_parameter' => 339,
			'unsigned_real' => 50,
			'identifier' => 280,
			'set_constructor' => 273,
			'exponentiation' => 279,
			'factor' => 272,
			'unsigned_integer' => 43,
			'term' => 274,
			'field_designator' => 239,
			'unsigned_constant' => 278,
			'actual_parameter_list' => 338,
			'primary' => 277,
			'variable_access' => 287,
			'expression' => 337,
			'sign' => 284
		}
	},
	{#State 303
		DEFAULT => -179
	},
	{#State 304
		ACTIONS => {
			'ASSIGNMENT' => 340
		}
	},
	{#State 305
		DEFAULT => -198
	},
	{#State 306
		DEFAULT => -62
	},
	{#State 307
		ACTIONS => {
			'MINUS' => 49,
			'REALNUMBER' => 112,
			'CHARACTER_STRING' => 127,
			'PLUS' => 42,
			'DIGSEQ' => 117,
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'identifier' => 184,
			'sign' => 133,
			'constant' => 341,
			'non_string' => 132
		}
	},
	{#State 308
		ACTIONS => {
			'IDENTIFIER' => 12,
			'DIGSEQ' => 117,
			'PLUS' => 42,
			'CHARACTER_STRING' => 127,
			'REALNUMBER' => 112,
			'MINUS' => 49
		},
		GOTOS => {
			'case_constant' => 342,
			'sign' => 133,
			'identifier' => 184,
			'non_string' => 132,
			'constant' => 264
		}
	},
	{#State 309
		ACTIONS => {
			'LPAREN' => 343
		}
	},
	{#State 310
		ACTIONS => {
			'MINUS' => 49,
			'REALNUMBER' => 112,
			'CHARACTER_STRING' => 127,
			'DIGSEQ' => 117,
			'PLUS' => 42,
			'IDENTIFIER' => 12
		},
		DEFAULT => -75,
		GOTOS => {
			'non_string' => 132,
			'constant' => 264,
			'case_constant' => 266,
			'variant' => 344,
			'case_constant_list' => 265,
			'identifier' => 184,
			'sign' => 133
		}
	},
	{#State 311
		ACTIONS => {
			'LBRAC' => 275,
			'CHARACTER_STRING' => 36,
			'LPAREN' => 276,
			'MINUS' => 49,
			'NIL' => 38,
			'NOT' => 286,
			'REALNUMBER' => 53,
			'PLUS' => 42,
			'DIGSEQ' => 41,
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'primary' => 277,
			'variable_access' => 287,
			'boolean_expression' => 345,
			'sign' => 284,
			'expression' => 285,
			'indexed_variable' => 243,
			'identifier' => 280,
			'unsigned_real' => 50,
			'simple_expression' => 282,
			'unsigned_number' => 46,
			'function_designator' => 281,
			'unsigned_constant' => 278,
			'factor' => 272,
			'set_constructor' => 273,
			'exponentiation' => 279,
			'unsigned_integer' => 43,
			'field_designator' => 239,
			'term' => 274
		}
	},
	{#State 312
		ACTIONS => {
			'REALNUMBER' => 53,
			'NOT' => 286,
			'NIL' => 38,
			'MINUS' => 49,
			'LPAREN' => 276,
			'CHARACTER_STRING' => 36,
			'LBRAC' => 275,
			'IDENTIFIER' => 12,
			'PLUS' => 42,
			'DIGSEQ' => 41
		},
		GOTOS => {
			'indexed_variable' => 243,
			'unsigned_real' => 50,
			'identifier' => 280,
			'function_designator' => 281,
			'unsigned_number' => 46,
			'primary' => 277,
			'variable_access' => 287,
			'sign' => 284,
			'unsigned_constant' => 278,
			'exponentiation' => 279,
			'factor' => 346,
			'set_constructor' => 273,
			'field_designator' => 239,
			'unsigned_integer' => 43
		}
	},
	{#State 313
		DEFAULT => -235
	},
	{#State 314
		ACTIONS => {
			'DOTDOT' => 347
		},
		DEFAULT => -233
	},
	{#State 315
		ACTIONS => {
			'RBRAC' => 348,
			'COMMA' => 74
		},
		GOTOS => {
			'comma' => 349
		}
	},
	{#State 316
		DEFAULT => -231
	},
	{#State 317
		ACTIONS => {
			'RPAREN' => 350
		}
	},
	{#State 318
		ACTIONS => {
			'LPAREN' => 276,
			'LBRAC' => 275,
			'CHARACTER_STRING' => 36,
			'NIL' => 38,
			'REALNUMBER' => 53,
			'NOT' => 286,
			'IDENTIFIER' => 12,
			'DIGSEQ' => 41
		},
		GOTOS => {
			'unsigned_constant' => 278,
			'field_designator' => 239,
			'unsigned_integer' => 43,
			'exponentiation' => 351,
			'set_constructor' => 273,
			'unsigned_real' => 50,
			'identifier' => 280,
			'indexed_variable' => 243,
			'variable_access' => 287,
			'unsigned_number' => 46,
			'function_designator' => 281,
			'primary' => 277
		}
	},
	{#State 319
		DEFAULT => -229
	},
	{#State 320
		ACTIONS => {
			'CHARACTER_STRING' => 36,
			'LBRAC' => 275,
			'LPAREN' => 276,
			'MINUS' => 49,
			'NOT' => 286,
			'REALNUMBER' => 53,
			'NIL' => 38,
			'DIGSEQ' => 41,
			'PLUS' => 42,
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'exponentiation' => 279,
			'factor' => 272,
			'set_constructor' => 273,
			'term' => 352,
			'field_designator' => 239,
			'unsigned_integer' => 43,
			'sign' => 284,
			'unsigned_constant' => 278,
			'unsigned_number' => 46,
			'function_designator' => 281,
			'primary' => 277,
			'variable_access' => 287,
			'indexed_variable' => 243,
			'identifier' => 280,
			'unsigned_real' => 50
		}
	},
	{#State 321
		ACTIONS => {
			'PLUS' => 42,
			'DIGSEQ' => 41,
			'IDENTIFIER' => 12,
			'MINUS' => 49,
			'REALNUMBER' => 53,
			'NOT' => 286,
			'NIL' => 38,
			'CHARACTER_STRING' => 36,
			'LBRAC' => 275,
			'LPAREN' => 276
		},
		GOTOS => {
			'variable_access' => 287,
			'primary' => 277,
			'sign' => 284,
			'unsigned_real' => 50,
			'identifier' => 280,
			'indexed_variable' => 243,
			'unsigned_number' => 46,
			'function_designator' => 281,
			'simple_expression' => 353,
			'unsigned_constant' => 278,
			'term' => 274,
			'field_designator' => 239,
			'unsigned_integer' => 43,
			'factor' => 272,
			'set_constructor' => 273,
			'exponentiation' => 279
		}
	},
	{#State 322
		ACTIONS => {
			'IDENTIFIER' => 12,
			'DIGSEQ' => 30,
			'GOTO' => 253,
			'WHILE' => 254,
			'PBEGIN' => 214,
			'REPEAT' => 231,
			'FOR' => 259,
			'IF' => 233,
			'CASE' => 242,
			'WITH' => 248
		},
		DEFAULT => -154,
		GOTOS => {
			'closed_if_statement' => 252,
			'closed_statement' => 355,
			'compound_statement' => 238,
			'open_statement' => 237,
			'closed_with_statement' => 236,
			'field_designator' => 239,
			'open_while_statement' => 240,
			'identifier' => 255,
			'case_statement' => 256,
			'indexed_variable' => 243,
			'statement' => 354,
			'open_if_statement' => 244,
			'open_for_statement' => 257,
			'label' => 245,
			'goto_statement' => 228,
			'non_labeled_open_statement' => 229,
			'procedure_statement' => 230,
			'non_labeled_closed_statement' => 232,
			'repeat_statement' => 246,
			'closed_for_statement' => 234,
			'open_with_statement' => 247,
			'assignment_statement' => 249,
			'variable_access' => 250,
			'closed_while_statement' => 251
		}
	},
	{#State 323
		DEFAULT => -212
	},
	{#State 324
		DEFAULT => -221
	},
	{#State 325
		DEFAULT => -136
	},
	{#State 326
		ACTIONS => {
			'CHARACTER_STRING' => 127,
			'DIGSEQ' => 117,
			'PLUS' => 42,
			'IDENTIFIER' => 12,
			'MINUS' => 49,
			'REALNUMBER' => 112
		},
		GOTOS => {
			'case_list_element_list' => 356,
			'identifier' => 184,
			'case_list_element' => 358,
			'case_constant' => 266,
			'constant' => 264,
			'non_string' => 132,
			'sign' => 133,
			'case_constant_list' => 357
		}
	},
	{#State 327
		DEFAULT => -142
	},
	{#State 328
		DEFAULT => -140
	},
	{#State 329
		ACTIONS => {
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'indexed_variable' => 243,
			'identifier' => 294,
			'field_designator' => 239,
			'variable_access' => 359
		}
	},
	{#State 330
		ACTIONS => {
			'IF' => 233,
			'WITH' => 248,
			'CASE' => 242,
			'FOR' => 259,
			'REPEAT' => 231,
			'PBEGIN' => 214,
			'IDENTIFIER' => 12,
			'DIGSEQ' => 30,
			'GOTO' => 253,
			'WHILE' => 254
		},
		DEFAULT => -154,
		GOTOS => {
			'non_labeled_open_statement' => 229,
			'procedure_statement' => 230,
			'goto_statement' => 228,
			'non_labeled_closed_statement' => 232,
			'repeat_statement' => 246,
			'closed_for_statement' => 234,
			'assignment_statement' => 249,
			'open_with_statement' => 247,
			'variable_access' => 250,
			'closed_while_statement' => 251,
			'closed_if_statement' => 252,
			'closed_statement' => 360,
			'open_statement' => 361,
			'compound_statement' => 238,
			'closed_with_statement' => 236,
			'field_designator' => 239,
			'open_while_statement' => 240,
			'identifier' => 255,
			'case_statement' => 256,
			'indexed_variable' => 243,
			'open_if_statement' => 244,
			'open_for_statement' => 257,
			'label' => 245
		}
	},
	{#State 331
		DEFAULT => -169
	},
	{#State 332
		DEFAULT => -176
	},
	{#State 333
		ACTIONS => {
			'COMMA' => 74,
			'RBRAC' => 363
		},
		GOTOS => {
			'comma' => 362
		}
	},
	{#State 334
		DEFAULT => -177
	},
	{#State 335
		DEFAULT => -178
	},
	{#State 336
		ACTIONS => {
			'PBEGIN' => 214,
			'REPEAT' => 231,
			'DIGSEQ' => 30,
			'GOTO' => 253,
			'WHILE' => 254,
			'IDENTIFIER' => 12,
			'WITH' => 248,
			'CASE' => 242,
			'IF' => 233,
			'FOR' => 259
		},
		DEFAULT => -154,
		GOTOS => {
			'repeat_statement' => 246,
			'non_labeled_closed_statement' => 232,
			'goto_statement' => 228,
			'non_labeled_open_statement' => 229,
			'procedure_statement' => 230,
			'closed_while_statement' => 251,
			'variable_access' => 250,
			'open_with_statement' => 247,
			'assignment_statement' => 249,
			'closed_for_statement' => 234,
			'field_designator' => 239,
			'open_while_statement' => 240,
			'open_statement' => 365,
			'compound_statement' => 238,
			'closed_with_statement' => 236,
			'closed_statement' => 364,
			'closed_if_statement' => 252,
			'label' => 245,
			'open_for_statement' => 257,
			'open_if_statement' => 244,
			'indexed_variable' => 243,
			'case_statement' => 256,
			'identifier' => 255
		}
	},
	{#State 337
		ACTIONS => {
			'COLON' => 366
		},
		DEFAULT => -184
	},
	{#State 338
		ACTIONS => {
			'RPAREN' => 367,
			'COMMA' => 74
		},
		GOTOS => {
			'comma' => 368
		}
	},
	{#State 339
		DEFAULT => -183
	},
	{#State 340
		ACTIONS => {
			'MINUS' => 49,
			'NIL' => 38,
			'NOT' => 286,
			'REALNUMBER' => 53,
			'LBRAC' => 275,
			'CHARACTER_STRING' => 36,
			'LPAREN' => 276,
			'PLUS' => 42,
			'DIGSEQ' => 41,
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'variable_access' => 287,
			'primary' => 277,
			'sign' => 284,
			'initial_value' => 370,
			'expression' => 369,
			'identifier' => 280,
			'unsigned_real' => 50,
			'indexed_variable' => 243,
			'unsigned_number' => 46,
			'function_designator' => 281,
			'simple_expression' => 282,
			'unsigned_constant' => 278,
			'field_designator' => 239,
			'term' => 274,
			'unsigned_integer' => 43,
			'exponentiation' => 279,
			'set_constructor' => 273,
			'factor' => 272
		}
	},
	{#State 341
		DEFAULT => -88
	},
	{#State 342
		DEFAULT => -85
	},
	{#State 343
		ACTIONS => {
			'IDENTIFIER' => 12,
			'CASE' => 179
		},
		DEFAULT => -77,
		GOTOS => {
			'identifier' => 55,
			'identifier_list' => 180,
			'record_section_list' => 372,
			'variant_part' => 371,
			'record_section' => 178
		}
	},
	{#State 344
		DEFAULT => -80
	},
	{#State 345
		DEFAULT => -159
	},
	{#State 346
		DEFAULT => -211
	},
	{#State 347
		ACTIONS => {
			'CHARACTER_STRING' => 36,
			'LBRAC' => 275,
			'LPAREN' => 276,
			'MINUS' => 49,
			'NOT' => 286,
			'REALNUMBER' => 53,
			'NIL' => 38,
			'PLUS' => 42,
			'DIGSEQ' => 41,
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'expression' => 373,
			'sign' => 284,
			'variable_access' => 287,
			'primary' => 277,
			'term' => 274,
			'field_designator' => 239,
			'unsigned_integer' => 43,
			'factor' => 272,
			'exponentiation' => 279,
			'set_constructor' => 273,
			'unsigned_constant' => 278,
			'unsigned_number' => 46,
			'function_designator' => 281,
			'simple_expression' => 282,
			'identifier' => 280,
			'unsigned_real' => 50,
			'indexed_variable' => 243
		}
	},
	{#State 348
		DEFAULT => -230
	},
	{#State 349
		ACTIONS => {
			'DIGSEQ' => 41,
			'PLUS' => 42,
			'IDENTIFIER' => 12,
			'MINUS' => 49,
			'NOT' => 286,
			'REALNUMBER' => 53,
			'NIL' => 38,
			'CHARACTER_STRING' => 36,
			'LBRAC' => 275,
			'LPAREN' => 276
		},
		GOTOS => {
			'unsigned_number' => 46,
			'function_designator' => 281,
			'simple_expression' => 282,
			'unsigned_real' => 50,
			'identifier' => 280,
			'indexed_variable' => 243,
			'field_designator' => 239,
			'term' => 274,
			'unsigned_integer' => 43,
			'factor' => 272,
			'exponentiation' => 279,
			'set_constructor' => 273,
			'unsigned_constant' => 278,
			'variable_access' => 287,
			'primary' => 277,
			'member_designator' => 374,
			'expression' => 313,
			'sign' => 284
		}
	},
	{#State 350
		DEFAULT => -220
	},
	{#State 351
		DEFAULT => -215
	},
	{#State 352
		ACTIONS => {
			'AND' => 82,
			'SLASH' => 83,
			'DIV' => 81,
			'MOD' => 79,
			'STAR' => 80
		},
		DEFAULT => -209,
		GOTOS => {
			'mulop' => 312
		}
	},
	{#State 353
		ACTIONS => {
			'PLUS' => 98,
			'OR' => 95,
			'MINUS' => 93
		},
		DEFAULT => -207,
		GOTOS => {
			'addop' => 320
		}
	},
	{#State 354
		DEFAULT => -166
	},
	{#State 355
		ACTIONS => {
			'ELSE' => 375
		},
		DEFAULT => -139
	},
	{#State 356
		ACTIONS => {
			'END' => 376,
			'SEMICOLON' => 378
		},
		GOTOS => {
			'semicolon' => 377
		}
	},
	{#State 357
		ACTIONS => {
			'COMMA' => 74,
			'COLON' => 379
		},
		GOTOS => {
			'comma' => 308
		}
	},
	{#State 358
		DEFAULT => -194
	},
	{#State 359
		ACTIONS => {
			'DOT' => 298,
			'UPARROW' => 299,
			'LBRAC' => 297
		},
		DEFAULT => -203
	},
	{#State 360
		DEFAULT => -165
	},
	{#State 361
		DEFAULT => -164
	},
	{#State 362
		ACTIONS => {
			'PLUS' => 42,
			'DIGSEQ' => 41,
			'IDENTIFIER' => 12,
			'CHARACTER_STRING' => 36,
			'LBRAC' => 275,
			'LPAREN' => 276,
			'MINUS' => 49,
			'REALNUMBER' => 53,
			'NOT' => 286,
			'NIL' => 38
		},
		GOTOS => {
			'expression' => 334,
			'sign' => 284,
			'primary' => 277,
			'index_expression' => 380,
			'variable_access' => 287,
			'exponentiation' => 279,
			'set_constructor' => 273,
			'factor' => 272,
			'unsigned_integer' => 43,
			'field_designator' => 239,
			'term' => 274,
			'unsigned_constant' => 278,
			'simple_expression' => 282,
			'function_designator' => 281,
			'unsigned_number' => 46,
			'indexed_variable' => 243,
			'unsigned_real' => 50,
			'identifier' => 280
		}
	},
	{#State 363
		DEFAULT => -174
	},
	{#State 364
		DEFAULT => -161
	},
	{#State 365
		DEFAULT => -160
	},
	{#State 366
		ACTIONS => {
			'PLUS' => 42,
			'DIGSEQ' => 41,
			'IDENTIFIER' => 12,
			'MINUS' => 49,
			'NIL' => 38,
			'REALNUMBER' => 53,
			'NOT' => 286,
			'LBRAC' => 275,
			'CHARACTER_STRING' => 36,
			'LPAREN' => 276
		},
		GOTOS => {
			'primary' => 277,
			'variable_access' => 287,
			'expression' => 381,
			'sign' => 284,
			'simple_expression' => 282,
			'unsigned_number' => 46,
			'function_designator' => 281,
			'indexed_variable' => 243,
			'unsigned_real' => 50,
			'identifier' => 280,
			'exponentiation' => 279,
			'factor' => 272,
			'set_constructor' => 273,
			'unsigned_integer' => 43,
			'term' => 274,
			'field_designator' => 239,
			'unsigned_constant' => 278
		}
	},
	{#State 367
		DEFAULT => -181
	},
	{#State 368
		ACTIONS => {
			'LPAREN' => 276,
			'LBRAC' => 275,
			'CHARACTER_STRING' => 36,
			'NIL' => 38,
			'REALNUMBER' => 53,
			'NOT' => 286,
			'MINUS' => 49,
			'IDENTIFIER' => 12,
			'DIGSEQ' => 41,
			'PLUS' => 42
		},
		GOTOS => {
			'unsigned_number' => 46,
			'function_designator' => 281,
			'simple_expression' => 282,
			'identifier' => 280,
			'unsigned_real' => 50,
			'actual_parameter' => 382,
			'indexed_variable' => 243,
			'field_designator' => 239,
			'term' => 274,
			'unsigned_integer' => 43,
			'exponentiation' => 279,
			'factor' => 272,
			'set_constructor' => 273,
			'unsigned_constant' => 278,
			'variable_access' => 287,
			'primary' => 277,
			'expression' => 337,
			'sign' => 284
		}
	},
	{#State 369
		DEFAULT => -199
	},
	{#State 370
		ACTIONS => {
			'DOWNTO' => 383,
			'TO' => 385
		},
		GOTOS => {
			'direction' => 384
		}
	},
	{#State 371
		ACTIONS => {
			'RPAREN' => 386
		}
	},
	{#State 372
		ACTIONS => {
			'RPAREN' => 388,
			'SEMICOLON' => 9
		},
		GOTOS => {
			'semicolon' => 387
		}
	},
	{#State 373
		DEFAULT => -234
	},
	{#State 374
		ACTIONS => {
			'DOTDOT' => 347
		},
		DEFAULT => -232
	},
	{#State 375
		ACTIONS => {
			'REPEAT' => 231,
			'PBEGIN' => 214,
			'IDENTIFIER' => 12,
			'DIGSEQ' => 30,
			'GOTO' => 253,
			'WHILE' => 254,
			'IF' => 233,
			'CASE' => 242,
			'WITH' => 248,
			'FOR' => 259
		},
		DEFAULT => -154,
		GOTOS => {
			'non_labeled_closed_statement' => 232,
			'goto_statement' => 228,
			'procedure_statement' => 230,
			'non_labeled_open_statement' => 229,
			'repeat_statement' => 246,
			'assignment_statement' => 249,
			'open_with_statement' => 247,
			'closed_for_statement' => 234,
			'closed_while_statement' => 251,
			'variable_access' => 250,
			'closed_with_statement' => 236,
			'open_statement' => 389,
			'compound_statement' => 238,
			'closed_statement' => 390,
			'closed_if_statement' => 252,
			'open_while_statement' => 240,
			'field_designator' => 239,
			'indexed_variable' => 243,
			'case_statement' => 256,
			'identifier' => 255,
			'label' => 245,
			'open_for_statement' => 257,
			'open_if_statement' => 244
		}
	},
	{#State 376
		DEFAULT => -188
	},
	{#State 377
		ACTIONS => {
			'MINUS' => 49,
			'REALNUMBER' => 112,
			'OTHERWISE' => 391,
			'PLUS' => 42,
			'DIGSEQ' => 117,
			'CHARACTER_STRING' => 127,
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'otherwisepart' => 393,
			'non_string' => 132,
			'constant' => 264,
			'sign' => 133,
			'case_constant_list' => 357,
			'identifier' => 184,
			'case_constant' => 266,
			'case_list_element' => 392
		}
	},
	{#State 378
		ACTIONS => {
			'END' => 394
		},
		DEFAULT => -252
	},
	{#State 379
		ACTIONS => {
			'WHILE' => 254,
			'DIGSEQ' => 30,
			'GOTO' => 253,
			'IDENTIFIER' => 12,
			'REPEAT' => 231,
			'PBEGIN' => 214,
			'FOR' => 259,
			'CASE' => 242,
			'WITH' => 248,
			'IF' => 233
		},
		DEFAULT => -154,
		GOTOS => {
			'closed_for_statement' => 234,
			'open_with_statement' => 247,
			'assignment_statement' => 249,
			'variable_access' => 250,
			'closed_while_statement' => 251,
			'non_labeled_open_statement' => 229,
			'procedure_statement' => 230,
			'goto_statement' => 228,
			'non_labeled_closed_statement' => 232,
			'repeat_statement' => 246,
			'identifier' => 255,
			'case_statement' => 256,
			'indexed_variable' => 243,
			'statement' => 395,
			'open_if_statement' => 244,
			'open_for_statement' => 257,
			'label' => 245,
			'closed_if_statement' => 252,
			'closed_statement' => 235,
			'open_statement' => 237,
			'closed_with_statement' => 236,
			'compound_statement' => 238,
			'field_designator' => 239,
			'open_while_statement' => 240
		}
	},
	{#State 380
		DEFAULT => -175
	},
	{#State 381
		ACTIONS => {
			'COLON' => 396
		},
		DEFAULT => -185
	},
	{#State 382
		DEFAULT => -182
	},
	{#State 383
		DEFAULT => -201
	},
	{#State 384
		ACTIONS => {
			'MINUS' => 49,
			'NIL' => 38,
			'NOT' => 286,
			'REALNUMBER' => 53,
			'LBRAC' => 275,
			'CHARACTER_STRING' => 36,
			'LPAREN' => 276,
			'DIGSEQ' => 41,
			'PLUS' => 42,
			'IDENTIFIER' => 12
		},
		GOTOS => {
			'unsigned_constant' => 278,
			'unsigned_integer' => 43,
			'field_designator' => 239,
			'term' => 274,
			'factor' => 272,
			'exponentiation' => 279,
			'set_constructor' => 273,
			'unsigned_real' => 50,
			'identifier' => 280,
			'indexed_variable' => 243,
			'simple_expression' => 282,
			'function_designator' => 281,
			'unsigned_number' => 46,
			'sign' => 284,
			'expression' => 397,
			'final_value' => 398,
			'variable_access' => 287,
			'primary' => 277
		}
	},
	{#State 385
		DEFAULT => -200
	},
	{#State 386
		DEFAULT => -84
	},
	{#State 387
		ACTIONS => {
			'IDENTIFIER' => 12,
			'CASE' => 179
		},
		DEFAULT => -77,
		GOTOS => {
			'identifier_list' => 180,
			'identifier' => 55,
			'record_section' => 224,
			'variant_part' => 399
		}
	},
	{#State 388
		DEFAULT => -82
	},
	{#State 389
		DEFAULT => -167
	},
	{#State 390
		DEFAULT => -168
	},
	{#State 391
		ACTIONS => {
			'COLON' => 400
		},
		DEFAULT => -196
	},
	{#State 392
		DEFAULT => -193
	},
	{#State 393
		ACTIONS => {
			'WITH' => 248,
			'CASE' => 242,
			'IF' => 233,
			'FOR' => 259,
			'PBEGIN' => 214,
			'REPEAT' => 231,
			'GOTO' => 253,
			'WHILE' => 254,
			'DIGSEQ' => 30,
			'IDENTIFIER' => 12
		},
		DEFAULT => -154,
		GOTOS => {
			'field_designator' => 239,
			'open_while_statement' => 240,
			'compound_statement' => 238,
			'closed_with_statement' => 236,
			'open_statement' => 237,
			'closed_statement' => 235,
			'closed_if_statement' => 252,
			'label' => 245,
			'open_for_statement' => 257,
			'statement' => 401,
			'open_if_statement' => 244,
			'indexed_variable' => 243,
			'case_statement' => 256,
			'identifier' => 255,
			'repeat_statement' => 246,
			'non_labeled_closed_statement' => 232,
			'procedure_statement' => 230,
			'non_labeled_open_statement' => 229,
			'goto_statement' => 228,
			'closed_while_statement' => 251,
			'variable_access' => 250,
			'open_with_statement' => 247,
			'assignment_statement' => 249,
			'closed_for_statement' => 234
		}
	},
	{#State 394
		DEFAULT => -189
	},
	{#State 395
		DEFAULT => -195
	},
	{#State 396
		ACTIONS => {
			'PLUS' => 42,
			'DIGSEQ' => 41,
			'IDENTIFIER' => 12,
			'MINUS' => 49,
			'NOT' => 286,
			'REALNUMBER' => 53,
			'NIL' => 38,
			'CHARACTER_STRING' => 36,
			'LBRAC' => 275,
			'LPAREN' => 276
		},
		GOTOS => {
			'variable_access' => 287,
			'primary' => 277,
			'sign' => 284,
			'expression' => 402,
			'unsigned_real' => 50,
			'identifier' => 280,
			'indexed_variable' => 243,
			'function_designator' => 281,
			'unsigned_number' => 46,
			'simple_expression' => 282,
			'unsigned_constant' => 278,
			'term' => 274,
			'field_designator' => 239,
			'unsigned_integer' => 43,
			'exponentiation' => 279,
			'factor' => 272,
			'set_constructor' => 273
		}
	},
	{#State 397
		DEFAULT => -202
	},
	{#State 398
		ACTIONS => {
			'DO' => 403
		}
	},
	{#State 399
		ACTIONS => {
			'RPAREN' => 404
		}
	},
	{#State 400
		DEFAULT => -197
	},
	{#State 401
		ACTIONS => {
			'END' => 406,
			'SEMICOLON' => 405
		}
	},
	{#State 402
		DEFAULT => -186
	},
	{#State 403
		ACTIONS => {
			'GOTO' => 253,
			'DIGSEQ' => 30,
			'WHILE' => 254,
			'IDENTIFIER' => 12,
			'REPEAT' => 231,
			'PBEGIN' => 214,
			'FOR' => 259,
			'WITH' => 248,
			'CASE' => 242,
			'IF' => 233
		},
		DEFAULT => -154,
		GOTOS => {
			'non_labeled_open_statement' => 229,
			'goto_statement' => 228,
			'procedure_statement' => 230,
			'non_labeled_closed_statement' => 232,
			'repeat_statement' => 246,
			'closed_for_statement' => 234,
			'open_with_statement' => 247,
			'assignment_statement' => 249,
			'variable_access' => 250,
			'closed_while_statement' => 251,
			'closed_if_statement' => 252,
			'closed_statement' => 407,
			'compound_statement' => 238,
			'open_statement' => 408,
			'closed_with_statement' => 236,
			'open_while_statement' => 240,
			'field_designator' => 239,
			'identifier' => 255,
			'case_statement' => 256,
			'indexed_variable' => 243,
			'open_for_statement' => 257,
			'open_if_statement' => 244,
			'label' => 245
		}
	},
	{#State 404
		DEFAULT => -83
	},
	{#State 405
		ACTIONS => {
			'END' => 409
		}
	},
	{#State 406
		DEFAULT => -190
	},
	{#State 407
		DEFAULT => -163
	},
	{#State 408
		DEFAULT => -162
	},
	{#State 409
		DEFAULT => -191
	}
],
    yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 4376 ./pascal.pm
	],
	[#Rule file_is_program
		 'file', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4383 ./pascal.pm
	],
	[#Rule file_is_module
		 'file', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4390 ./pascal.pm
	],
	[#Rule program_is_programHeading_semicolon_block_DOT
		 'program', 4,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4397 ./pascal.pm
	],
	[#Rule programHeading_is_PROGRAM_identifier
		 'program_heading', 2,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4404 ./pascal.pm
	],
	[#Rule programHeading_is_PROGRAM_identifier_LPAREN_identifierList_RPAREN
		 'program_heading', 5,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4411 ./pascal.pm
	],
	[#Rule identifierList_is_identifierList_comma_identifier
		 'identifier_list', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4418 ./pascal.pm
	],
	[#Rule identifierList_is_identifier
		 'identifier_list', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4425 ./pascal.pm
	],
	[#Rule block_is_labelDeclarationPart_constantDefinitionPart_typeDefinitionPart_variableDeclarationPart_procedureAndFunctionDeclarationPart_statementPart
		 'block', 6,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4432 ./pascal.pm
	],
	[#Rule module_is_constantDefinitionPart_typeDefinitionPart_variableDeclarationPart_procedureAndFunctionDeclarationPart
		 'module', 4,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4439 ./pascal.pm
	],
	[#Rule labelDeclarationPart_is_LABEL_labelList_semicolon
		 'label_declaration_part', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4446 ./pascal.pm
	],
	[#Rule labelDeclarationPart_is_empty
		 'label_declaration_part', 0,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4453 ./pascal.pm
	],
	[#Rule labelList_is_labelList_comma_label
		 'label_list', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4460 ./pascal.pm
	],
	[#Rule labelList_is_label
		 'label_list', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4467 ./pascal.pm
	],
	[#Rule label_is_DIGSEQ
		 'label', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4474 ./pascal.pm
	],
	[#Rule constantDefinitionPart_is_CONST_constantList
		 'constant_definition_part', 2,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4481 ./pascal.pm
	],
	[#Rule constantDefinitionPart_is_empty
		 'constant_definition_part', 0,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4488 ./pascal.pm
	],
	[#Rule constantList_is_constantList_constantDefinition
		 'constant_list', 2,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4495 ./pascal.pm
	],
	[#Rule constantList_is_constantDefinition
		 'constant_list', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4502 ./pascal.pm
	],
	[#Rule constantDefinition_is_identifier_EQUAL_cexpression_semicolon
		 'constant_definition', 4,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4509 ./pascal.pm
	],
	[#Rule cexpression_is_csimpleExpression
		 'cexpression', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4516 ./pascal.pm
	],
	[#Rule cexpression_is_csimpleExpression_relop_csimpleExpression
		 'cexpression', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4523 ./pascal.pm
	],
	[#Rule csimpleExpression_is_cterm
		 'csimple_expression', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4530 ./pascal.pm
	],
	[#Rule csimpleExpression_is_csimpleExpression_addop_cterm
		 'csimple_expression', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4537 ./pascal.pm
	],
	[#Rule cterm_is_cfactor
		 'cterm', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4544 ./pascal.pm
	],
	[#Rule cterm_is_cterm_mulop_cfactor
		 'cterm', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4551 ./pascal.pm
	],
	[#Rule cfactor_is_sign_cfactor
		 'cfactor', 2,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4558 ./pascal.pm
	],
	[#Rule cfactor_is_cexponentiation
		 'cfactor', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4565 ./pascal.pm
	],
	[#Rule cexponentiation_is_cprimary
		 'cexponentiation', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4572 ./pascal.pm
	],
	[#Rule cexponentiation_is_cprimary_STARSTAR_cexponentiation
		 'cexponentiation', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4579 ./pascal.pm
	],
	[#Rule cprimary_is_identifier
		 'cprimary', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4586 ./pascal.pm
	],
	[#Rule cprimary_is_LPAREN_cexpression_RPAREN
		 'cprimary', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4593 ./pascal.pm
	],
	[#Rule cprimary_is_unsignedConstant
		 'cprimary', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4600 ./pascal.pm
	],
	[#Rule cprimary_is_NOT_cprimary
		 'cprimary', 2,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4607 ./pascal.pm
	],
	[#Rule constant_is_nonString
		 'constant', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4614 ./pascal.pm
	],
	[#Rule constant_is_sign_nonString
		 'constant', 2,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4621 ./pascal.pm
	],
	[#Rule constant_is_CHARACTER_STRING
		 'constant', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4628 ./pascal.pm
	],
	[#Rule sign_is_PLUS
		 'sign', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4635 ./pascal.pm
	],
	[#Rule sign_is_MINUS
		 'sign', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4642 ./pascal.pm
	],
	[#Rule nonString_is_DIGSEQ
		 'non_string', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4649 ./pascal.pm
	],
	[#Rule nonString_is_identifier
		 'non_string', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4656 ./pascal.pm
	],
	[#Rule nonString_is_REALNUMBER
		 'non_string', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4663 ./pascal.pm
	],
	[#Rule typeDefinitionPart_is_TYPE_typeDefinitionList
		 'type_definition_part', 2,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4670 ./pascal.pm
	],
	[#Rule typeDefinitionPart_is_empty
		 'type_definition_part', 0,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4677 ./pascal.pm
	],
	[#Rule typeDefinitionList_is_typeDefinitionList_typeDefinition
		 'type_definition_list', 2,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4684 ./pascal.pm
	],
	[#Rule typeDefinitionList_is_typeDefinition
		 'type_definition_list', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4691 ./pascal.pm
	],
	[#Rule typeDefinition_is_identifier_EQUAL_typeDenoter_semicolon
		 'type_definition', 4,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4698 ./pascal.pm
	],
	[#Rule typeDenoter_is_identifier
		 'type_denoter', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4705 ./pascal.pm
	],
	[#Rule typeDenoter_is_newType
		 'type_denoter', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4712 ./pascal.pm
	],
	[#Rule newType_is_newOrdinalType
		 'new_type', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4719 ./pascal.pm
	],
	[#Rule newType_is_newStructuredType
		 'new_type', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4726 ./pascal.pm
	],
	[#Rule newType_is_newPointerType
		 'new_type', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4733 ./pascal.pm
	],
	[#Rule newOrdinalType_is_enumeratedType
		 'new_ordinal_type', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4740 ./pascal.pm
	],
	[#Rule newOrdinalType_is_subrangeType
		 'new_ordinal_type', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4747 ./pascal.pm
	],
	[#Rule enumeratedType_is_LPAREN_identifierList_RPAREN
		 'enumerated_type', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4754 ./pascal.pm
	],
	[#Rule subrangeType_is_constant_DOTDOT_constant
		 'subrange_type', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4761 ./pascal.pm
	],
	[#Rule newStructuredType_is_structuredType
		 'new_structured_type', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4768 ./pascal.pm
	],
	[#Rule newStructuredType_is_PACKED_structuredType
		 'new_structured_type', 2,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4775 ./pascal.pm
	],
	[#Rule structuredType_is_arrayType
		 'structured_type', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4782 ./pascal.pm
	],
	[#Rule structuredType_is_recordType
		 'structured_type', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4789 ./pascal.pm
	],
	[#Rule structuredType_is_setType
		 'structured_type', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4796 ./pascal.pm
	],
	[#Rule structuredType_is_fileType
		 'structured_type', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4803 ./pascal.pm
	],
	[#Rule arrayType_is_ARRAY_LBRAC_indexList_RBRAC_OF_componentType
		 'array_type', 6,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4810 ./pascal.pm
	],
	[#Rule indexList_is_indexList_comma_indexType
		 'index_list', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4817 ./pascal.pm
	],
	[#Rule indexList_is_indexType
		 'index_list', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4824 ./pascal.pm
	],
	[#Rule indexType_is_ordinalType
		 'index_type', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4831 ./pascal.pm
	],
	[#Rule ordinalType_is_newOrdinalType
		 'ordinal_type', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4838 ./pascal.pm
	],
	[#Rule ordinalType_is_identifier
		 'ordinal_type', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4845 ./pascal.pm
	],
	[#Rule componentType_is_typeDenoter
		 'component_type', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4852 ./pascal.pm
	],
	[#Rule recordType_is_RECORD_recordSectionList_END
		 'record_type', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4859 ./pascal.pm
	],
	[#Rule recordType_is_RECORD_recordSectionList_semicolon_variantPart_END
		 'record_type', 5,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4866 ./pascal.pm
	],
	[#Rule recordType_is_RECORD_variantPart_END
		 'record_type', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4873 ./pascal.pm
	],
	[#Rule recordSectionList_is_recordSectionList_semicolon_recordSection
		 'record_section_list', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4880 ./pascal.pm
	],
	[#Rule recordSectionList_is_recordSection
		 'record_section_list', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4887 ./pascal.pm
	],
	[#Rule recordSection_is_identifierList_COLON_typeDenoter
		 'record_section', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4894 ./pascal.pm
	],
	[#Rule variantPart_is_CASE_variantSelector_OF_variantList_semicolon
		 'variant_part', 5,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4901 ./pascal.pm
	],
	[#Rule variantPart_is_CASE_variantSelector_OF_variantList
		 'variant_part', 4,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4908 ./pascal.pm
	],
	[#Rule variantPart_is_empty
		 'variant_part', 0,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4915 ./pascal.pm
	],
	[#Rule variantSelector_is_tagField_COLON_tagType
		 'variant_selector', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4922 ./pascal.pm
	],
	[#Rule variantSelector_is_tagType
		 'variant_selector', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4929 ./pascal.pm
	],
	[#Rule variantList_is_variantList_semicolon_variant
		 'variant_list', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4936 ./pascal.pm
	],
	[#Rule variantList_is_variant
		 'variant_list', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4943 ./pascal.pm
	],
	[#Rule variant_is_caseConstantList_COLON_LPAREN_recordSectionList_RPAREN
		 'variant', 5,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4950 ./pascal.pm
	],
	[#Rule variant_is_caseConstantList_COLON_LPAREN_recordSectionList_semicolon_variantPart_RPAREN
		 'variant', 7,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4957 ./pascal.pm
	],
	[#Rule variant_is_caseConstantList_COLON_LPAREN_variantPart_RPAREN
		 'variant', 5,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4964 ./pascal.pm
	],
	[#Rule caseConstantList_is_caseConstantList_comma_caseConstant
		 'case_constant_list', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4971 ./pascal.pm
	],
	[#Rule caseConstantList_is_caseConstant
		 'case_constant_list', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4978 ./pascal.pm
	],
	[#Rule caseConstant_is_constant
		 'case_constant', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4985 ./pascal.pm
	],
	[#Rule caseConstant_is_constant_DOTDOT_constant
		 'case_constant', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4992 ./pascal.pm
	],
	[#Rule tagField_is_identifier
		 'tag_field', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 4999 ./pascal.pm
	],
	[#Rule tagType_is_identifier
		 'tag_type', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5006 ./pascal.pm
	],
	[#Rule setType_is_SET_OF_baseType
		 'set_type', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5013 ./pascal.pm
	],
	[#Rule baseType_is_ordinalType
		 'base_type', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5020 ./pascal.pm
	],
	[#Rule fileType_is_PFILE_OF_componentType
		 'file_type', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5027 ./pascal.pm
	],
	[#Rule newPointerType_is_UPARROW_domainType
		 'new_pointer_type', 2,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5034 ./pascal.pm
	],
	[#Rule domainType_is_identifier
		 'domain_type', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5041 ./pascal.pm
	],
	[#Rule variableDeclarationPart_is_VAR_variableDeclarationList_semicolon
		 'variable_declaration_part', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5048 ./pascal.pm
	],
	[#Rule variableDeclarationPart_is_empty
		 'variable_declaration_part', 0,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5055 ./pascal.pm
	],
	[#Rule variableDeclarationList_is_variableDeclarationList_semicolon_variableDeclaration
		 'variable_declaration_list', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5062 ./pascal.pm
	],
	[#Rule variableDeclarationList_is_variableDeclaration
		 'variable_declaration_list', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5069 ./pascal.pm
	],
	[#Rule variableDeclaration_is_identifierList_COLON_typeDenoter
		 'variable_declaration', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5076 ./pascal.pm
	],
	[#Rule procedureAndFunctionDeclarationPart_is_procOrFuncDeclarationList_semicolon
		 'procedure_and_function_declaration_part', 2,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5083 ./pascal.pm
	],
	[#Rule procedureAndFunctionDeclarationPart_is_empty
		 'procedure_and_function_declaration_part', 0,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5090 ./pascal.pm
	],
	[#Rule procOrFuncDeclarationList_is_procOrFuncDeclarationList_semicolon_procOrFuncDeclaration
		 'proc_or_func_declaration_list', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5097 ./pascal.pm
	],
	[#Rule procOrFuncDeclarationList_is_procOrFuncDeclaration
		 'proc_or_func_declaration_list', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5104 ./pascal.pm
	],
	[#Rule procOrFuncDeclaration_is_procedureDeclaration
		 'proc_or_func_declaration', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5111 ./pascal.pm
	],
	[#Rule procOrFuncDeclaration_is_functionDeclaration
		 'proc_or_func_declaration', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5118 ./pascal.pm
	],
	[#Rule procedureDeclaration_is_procedureHeading_semicolon_directive
		 'procedure_declaration', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5125 ./pascal.pm
	],
	[#Rule procedureDeclaration_is_procedureHeading_semicolon_procedureBlock
		 'procedure_declaration', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5132 ./pascal.pm
	],
	[#Rule procedureHeading_is_procedureIdentification
		 'procedure_heading', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5139 ./pascal.pm
	],
	[#Rule procedureHeading_is_procedureIdentification_formalParameterList
		 'procedure_heading', 2,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5146 ./pascal.pm
	],
	[#Rule directive_is_FORWARD
		 'directive', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5153 ./pascal.pm
	],
	[#Rule directive_is_EXTERNAL
		 'directive', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5160 ./pascal.pm
	],
	[#Rule formalParameterList_is_LPAREN_formalParameterSectionList_RPAREN
		 'formal_parameter_list', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5167 ./pascal.pm
	],
	[#Rule formalParameterSectionList_is_formalParameterSectionList_semicolon_formalParameterSection
		 'formal_parameter_section_list', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5174 ./pascal.pm
	],
	[#Rule formalParameterSectionList_is_formalParameterSection
		 'formal_parameter_section_list', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5181 ./pascal.pm
	],
	[#Rule formalParameterSection_is_valueParameterSpecification
		 'formal_parameter_section', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5188 ./pascal.pm
	],
	[#Rule formalParameterSection_is_variableParameterSpecification
		 'formal_parameter_section', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5195 ./pascal.pm
	],
	[#Rule formalParameterSection_is_proceduralParameterSpecification
		 'formal_parameter_section', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5202 ./pascal.pm
	],
	[#Rule formalParameterSection_is_functionalParameterSpecification
		 'formal_parameter_section', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5209 ./pascal.pm
	],
	[#Rule valueParameterSpecification_is_identifierList_COLON_identifier
		 'value_parameter_specification', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5216 ./pascal.pm
	],
	[#Rule variableParameterSpecification_is_VAR_identifierList_COLON_identifier
		 'variable_parameter_specification', 4,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5223 ./pascal.pm
	],
	[#Rule proceduralParameterSpecification_is_procedureHeading
		 'procedural_parameter_specification', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5230 ./pascal.pm
	],
	[#Rule functionalParameterSpecification_is_functionHeading
		 'functional_parameter_specification', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5237 ./pascal.pm
	],
	[#Rule procedureIdentification_is_PROCEDURE_identifier
		 'procedure_identification', 2,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5244 ./pascal.pm
	],
	[#Rule procedureBlock_is_block
		 'procedure_block', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5251 ./pascal.pm
	],
	[#Rule functionDeclaration_is_functionHeading_semicolon_directive
		 'function_declaration', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5258 ./pascal.pm
	],
	[#Rule functionDeclaration_is_functionIdentification_semicolon_functionBlock
		 'function_declaration', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5265 ./pascal.pm
	],
	[#Rule functionDeclaration_is_functionHeading_semicolon_functionBlock
		 'function_declaration', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5272 ./pascal.pm
	],
	[#Rule functionHeading_is_FUNCTION_identifier_COLON_resultType
		 'function_heading', 4,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5279 ./pascal.pm
	],
	[#Rule functionHeading_is_FUNCTION_identifier_formalParameterList_COLON_resultType
		 'function_heading', 5,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5286 ./pascal.pm
	],
	[#Rule resultType_is_identifier
		 'result_type', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5293 ./pascal.pm
	],
	[#Rule functionIdentification_is_FUNCTION_identifier
		 'function_identification', 2,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5300 ./pascal.pm
	],
	[#Rule functionBlock_is_block
		 'function_block', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5307 ./pascal.pm
	],
	[#Rule statementPart_is_compoundStatement
		 'statement_part', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5314 ./pascal.pm
	],
	[#Rule compoundStatement_is_PBEGIN_statementSequence_END
		 'compound_statement', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5321 ./pascal.pm
	],
	[#Rule statementSequence_is_statementSequence_semicolon_statement
		 'statement_sequence', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5328 ./pascal.pm
	],
	[#Rule statementSequence_is_statement
		 'statement_sequence', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5335 ./pascal.pm
	],
	[#Rule statement_is_openStatement
		 'statement', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5342 ./pascal.pm
	],
	[#Rule statement_is_closedStatement
		 'statement', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5349 ./pascal.pm
	],
	[#Rule openStatement_is_label_COLON_nonLabeledOpenStatement
		 'open_statement', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5356 ./pascal.pm
	],
	[#Rule openStatement_is_nonLabeledOpenStatement
		 'open_statement', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5363 ./pascal.pm
	],
	[#Rule closedStatement_is_label_COLON_nonLabeledClosedStatement
		 'closed_statement', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5370 ./pascal.pm
	],
	[#Rule closedStatement_is_nonLabeledClosedStatement
		 'closed_statement', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5377 ./pascal.pm
	],
	[#Rule nonLabeledClosedStatement_is_assignmentStatement
		 'non_labeled_closed_statement', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5384 ./pascal.pm
	],
	[#Rule nonLabeledClosedStatement_is_procedureStatement
		 'non_labeled_closed_statement', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5391 ./pascal.pm
	],
	[#Rule nonLabeledClosedStatement_is_gotoStatement
		 'non_labeled_closed_statement', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5398 ./pascal.pm
	],
	[#Rule nonLabeledClosedStatement_is_compoundStatement
		 'non_labeled_closed_statement', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5405 ./pascal.pm
	],
	[#Rule nonLabeledClosedStatement_is_caseStatement
		 'non_labeled_closed_statement', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5412 ./pascal.pm
	],
	[#Rule nonLabeledClosedStatement_is_repeatStatement
		 'non_labeled_closed_statement', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5419 ./pascal.pm
	],
	[#Rule nonLabeledClosedStatement_is_closedWithStatement
		 'non_labeled_closed_statement', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5426 ./pascal.pm
	],
	[#Rule nonLabeledClosedStatement_is_closedIfStatement
		 'non_labeled_closed_statement', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5433 ./pascal.pm
	],
	[#Rule nonLabeledClosedStatement_is_closedWhileStatement
		 'non_labeled_closed_statement', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5440 ./pascal.pm
	],
	[#Rule nonLabeledClosedStatement_is_closedForStatement
		 'non_labeled_closed_statement', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5447 ./pascal.pm
	],
	[#Rule nonLabeledClosedStatement_is_empty
		 'non_labeled_closed_statement', 0,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5454 ./pascal.pm
	],
	[#Rule nonLabeledOpenStatement_is_openWithStatement
		 'non_labeled_open_statement', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5461 ./pascal.pm
	],
	[#Rule nonLabeledOpenStatement_is_openIfStatement
		 'non_labeled_open_statement', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5468 ./pascal.pm
	],
	[#Rule nonLabeledOpenStatement_is_openWhileStatement
		 'non_labeled_open_statement', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5475 ./pascal.pm
	],
	[#Rule nonLabeledOpenStatement_is_openForStatement
		 'non_labeled_open_statement', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5482 ./pascal.pm
	],
	[#Rule repeatStatement_is_REPEAT_statementSequence_UNTIL_booleanExpression
		 'repeat_statement', 4,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5489 ./pascal.pm
	],
	[#Rule openWhileStatement_is_WHILE_booleanExpression_DO_openStatement
		 'open_while_statement', 4,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5496 ./pascal.pm
	],
	[#Rule closedWhileStatement_is_WHILE_booleanExpression_DO_closedStatement
		 'closed_while_statement', 4,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5503 ./pascal.pm
	],
	[#Rule openForStatement_is_FOR_controlVariable_ASSIGNMENT_initialValue_direction_finalValue_DO_openStatement
		 'open_for_statement', 8,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5510 ./pascal.pm
	],
	[#Rule closedForStatement_is_FOR_controlVariable_ASSIGNMENT_initialValue_direction_finalValue_DO_closedStatement
		 'closed_for_statement', 8,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5517 ./pascal.pm
	],
	[#Rule openWithStatement_is_WITH_recordVariableList_DO_openStatement
		 'open_with_statement', 4,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5524 ./pascal.pm
	],
	[#Rule closedWithStatement_is_WITH_recordVariableList_DO_closedStatement
		 'closed_with_statement', 4,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5531 ./pascal.pm
	],
	[#Rule openIfStatement_is_IF_booleanExpression_THEN_statement
		 'open_if_statement', 4,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5538 ./pascal.pm
	],
	[#Rule openIfStatement_is_IF_booleanExpression_THEN_closedStatement_ELSE_openStatement
		 'open_if_statement', 6,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5545 ./pascal.pm
	],
	[#Rule closedIfStatement_is_IF_booleanExpression_THEN_closedStatement_ELSE_closedStatement
		 'closed_if_statement', 6,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5552 ./pascal.pm
	],
	[#Rule assignmentStatement_is_variableAccess_ASSIGNMENT_expression
		 'assignment_statement', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5559 ./pascal.pm
	],
	[#Rule variableAccess_is_identifier
		 'variable_access', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5566 ./pascal.pm
	],
	[#Rule variableAccess_is_indexedVariable
		 'variable_access', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5573 ./pascal.pm
	],
	[#Rule variableAccess_is_fieldDesignator
		 'variable_access', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5580 ./pascal.pm
	],
	[#Rule variableAccess_is_variableAccess_UPARROW
		 'variable_access', 2,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5587 ./pascal.pm
	],
	[#Rule indexedVariable_is_variableAccess_LBRAC_indexExpressionList_RBRAC
		 'indexed_variable', 4,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5594 ./pascal.pm
	],
	[#Rule indexExpressionList_is_indexExpressionList_comma_indexExpression
		 'index_expression_list', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5601 ./pascal.pm
	],
	[#Rule indexExpressionList_is_indexExpression
		 'index_expression_list', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5608 ./pascal.pm
	],
	[#Rule indexExpression_is_expression
		 'index_expression', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5615 ./pascal.pm
	],
	[#Rule fieldDesignator_is_variableAccess_DOT_identifier
		 'field_designator', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5622 ./pascal.pm
	],
	[#Rule procedureStatement_is_identifier_params
		 'procedure_statement', 2,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5629 ./pascal.pm
	],
	[#Rule procedureStatement_is_identifier
		 'procedure_statement', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5636 ./pascal.pm
	],
	[#Rule params_is_LPAREN_actualParameterList_RPAREN
		 'params', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5643 ./pascal.pm
	],
	[#Rule actualParameterList_is_actualParameterList_comma_actualParameter
		 'actual_parameter_list', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5650 ./pascal.pm
	],
	[#Rule actualParameterList_is_actualParameter
		 'actual_parameter_list', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5657 ./pascal.pm
	],
	[#Rule actualParameter_is_expression
		 'actual_parameter', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5664 ./pascal.pm
	],
	[#Rule actualParameter_is_expression_COLON_expression
		 'actual_parameter', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5671 ./pascal.pm
	],
	[#Rule actualParameter_is_expression_COLON_expression_COLON_expression
		 'actual_parameter', 5,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5678 ./pascal.pm
	],
	[#Rule gotoStatement_is_GOTO_label
		 'goto_statement', 2,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5685 ./pascal.pm
	],
	[#Rule caseStatement_is_CASE_caseIndex_OF_caseListElementList_END
		 'case_statement', 5,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5692 ./pascal.pm
	],
	[#Rule caseStatement_is_CASE_caseIndex_OF_caseListElementList_SEMICOLON_END
		 'case_statement', 6,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5699 ./pascal.pm
	],
	[#Rule caseStatement_is_CASE_caseIndex_OF_caseListElementList_semicolon_otherwisepart_statement_END
		 'case_statement', 8,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5706 ./pascal.pm
	],
	[#Rule caseStatement_is_CASE_caseIndex_OF_caseListElementList_semicolon_otherwisepart_statement_SEMICOLON_END
		 'case_statement', 9,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5713 ./pascal.pm
	],
	[#Rule caseIndex_is_expression
		 'case_index', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5720 ./pascal.pm
	],
	[#Rule caseListElementList_is_caseListElementList_semicolon_caseListElement
		 'case_list_element_list', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5727 ./pascal.pm
	],
	[#Rule caseListElementList_is_caseListElement
		 'case_list_element_list', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5734 ./pascal.pm
	],
	[#Rule caseListElement_is_caseConstantList_COLON_statement
		 'case_list_element', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5741 ./pascal.pm
	],
	[#Rule otherwisepart_is_OTHERWISE
		 'otherwisepart', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5748 ./pascal.pm
	],
	[#Rule otherwisepart_is_OTHERWISE_COLON
		 'otherwisepart', 2,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5755 ./pascal.pm
	],
	[#Rule controlVariable_is_identifier
		 'control_variable', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5762 ./pascal.pm
	],
	[#Rule initialValue_is_expression
		 'initial_value', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5769 ./pascal.pm
	],
	[#Rule direction_is_TO
		 'direction', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5776 ./pascal.pm
	],
	[#Rule direction_is_DOWNTO
		 'direction', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5783 ./pascal.pm
	],
	[#Rule finalValue_is_expression
		 'final_value', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5790 ./pascal.pm
	],
	[#Rule recordVariableList_is_recordVariableList_comma_variableAccess
		 'record_variable_list', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5797 ./pascal.pm
	],
	[#Rule recordVariableList_is_variableAccess
		 'record_variable_list', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5804 ./pascal.pm
	],
	[#Rule booleanExpression_is_expression
		 'boolean_expression', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5811 ./pascal.pm
	],
	[#Rule expression_is_simpleExpression
		 'expression', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5818 ./pascal.pm
	],
	[#Rule expression_is_simpleExpression_relop_simpleExpression
		 'expression', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5825 ./pascal.pm
	],
	[#Rule simpleExpression_is_term
		 'simple_expression', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5832 ./pascal.pm
	],
	[#Rule simpleExpression_is_simpleExpression_addop_term
		 'simple_expression', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5839 ./pascal.pm
	],
	[#Rule term_is_factor
		 'term', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5846 ./pascal.pm
	],
	[#Rule term_is_term_mulop_factor
		 'term', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5853 ./pascal.pm
	],
	[#Rule factor_is_sign_factor
		 'factor', 2,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5860 ./pascal.pm
	],
	[#Rule factor_is_exponentiation
		 'factor', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5867 ./pascal.pm
	],
	[#Rule exponentiation_is_primary
		 'exponentiation', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5874 ./pascal.pm
	],
	[#Rule exponentiation_is_primary_STARSTAR_exponentiation
		 'exponentiation', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5881 ./pascal.pm
	],
	[#Rule primary_is_variableAccess
		 'primary', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5888 ./pascal.pm
	],
	[#Rule primary_is_unsignedConstant
		 'primary', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5895 ./pascal.pm
	],
	[#Rule primary_is_functionDesignator
		 'primary', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5902 ./pascal.pm
	],
	[#Rule primary_is_setConstructor
		 'primary', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5909 ./pascal.pm
	],
	[#Rule primary_is_LPAREN_expression_RPAREN
		 'primary', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5916 ./pascal.pm
	],
	[#Rule primary_is_NOT_primary
		 'primary', 2,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5923 ./pascal.pm
	],
	[#Rule unsignedConstant_is_unsignedNumber
		 'unsigned_constant', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5930 ./pascal.pm
	],
	[#Rule unsignedConstant_is_CHARACTER_STRING
		 'unsigned_constant', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5937 ./pascal.pm
	],
	[#Rule unsignedConstant_is_NIL
		 'unsigned_constant', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5944 ./pascal.pm
	],
	[#Rule unsignedNumber_is_unsignedInteger
		 'unsigned_number', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5951 ./pascal.pm
	],
	[#Rule unsignedNumber_is_unsignedReal
		 'unsigned_number', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5958 ./pascal.pm
	],
	[#Rule unsignedInteger_is_DIGSEQ
		 'unsigned_integer', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5965 ./pascal.pm
	],
	[#Rule unsignedReal_is_REALNUMBER
		 'unsigned_real', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5972 ./pascal.pm
	],
	[#Rule functionDesignator_is_identifier_params
		 'function_designator', 2,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5979 ./pascal.pm
	],
	[#Rule setConstructor_is_LBRAC_memberDesignatorList_RBRAC
		 'set_constructor', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5986 ./pascal.pm
	],
	[#Rule setConstructor_is_LBRAC_RBRAC
		 'set_constructor', 2,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 5993 ./pascal.pm
	],
	[#Rule memberDesignatorList_is_memberDesignatorList_comma_memberDesignator
		 'member_designator_list', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6000 ./pascal.pm
	],
	[#Rule memberDesignatorList_is_memberDesignator
		 'member_designator_list', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6007 ./pascal.pm
	],
	[#Rule memberDesignator_is_memberDesignator_DOTDOT_expression
		 'member_designator', 3,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6014 ./pascal.pm
	],
	[#Rule memberDesignator_is_expression
		 'member_designator', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6021 ./pascal.pm
	],
	[#Rule addop_is_PLUS
		 'addop', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6028 ./pascal.pm
	],
	[#Rule addop_is_MINUS
		 'addop', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6035 ./pascal.pm
	],
	[#Rule addop_is_OR
		 'addop', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6042 ./pascal.pm
	],
	[#Rule mulop_is_STAR
		 'mulop', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6049 ./pascal.pm
	],
	[#Rule mulop_is_SLASH
		 'mulop', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6056 ./pascal.pm
	],
	[#Rule mulop_is_DIV
		 'mulop', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6063 ./pascal.pm
	],
	[#Rule mulop_is_MOD
		 'mulop', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6070 ./pascal.pm
	],
	[#Rule mulop_is_AND
		 'mulop', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6077 ./pascal.pm
	],
	[#Rule relop_is_EQUAL
		 'relop', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6084 ./pascal.pm
	],
	[#Rule relop_is_NOTEQUAL
		 'relop', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6091 ./pascal.pm
	],
	[#Rule relop_is_LT
		 'relop', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6098 ./pascal.pm
	],
	[#Rule relop_is_GT
		 'relop', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6105 ./pascal.pm
	],
	[#Rule relop_is_LE
		 'relop', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6112 ./pascal.pm
	],
	[#Rule relop_is_GE
		 'relop', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6119 ./pascal.pm
	],
	[#Rule relop_is_IN
		 'relop', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6126 ./pascal.pm
	],
	[#Rule identifier_is_IDENTIFIER
		 'identifier', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6133 ./pascal.pm
	],
	[#Rule semicolon_is_SEMICOLON
		 'semicolon', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6140 ./pascal.pm
	],
	[#Rule comma_is_COMMA
		 'comma', 1,
sub {
#line 28 "pascal.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 6147 ./pascal.pm
	]
],
#line 6150 ./pascal.pm
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
         'file_is_program', 
         'file_is_module', 
         'program_is_programHeading_semicolon_block_DOT', 
         'programHeading_is_PROGRAM_identifier', 
         'programHeading_is_PROGRAM_identifier_LPAREN_identifierList_RPAREN', 
         'identifierList_is_identifierList_comma_identifier', 
         'identifierList_is_identifier', 
         'block_is_labelDeclarationPart_constantDefinitionPart_typeDefinitionPart_variableDeclarationPart_procedureAndFunctionDeclarationPart_statementPart', 
         'module_is_constantDefinitionPart_typeDefinitionPart_variableDeclarationPart_procedureAndFunctionDeclarationPart', 
         'labelDeclarationPart_is_LABEL_labelList_semicolon', 
         'labelDeclarationPart_is_empty', 
         'labelList_is_labelList_comma_label', 
         'labelList_is_label', 
         'label_is_DIGSEQ', 
         'constantDefinitionPart_is_CONST_constantList', 
         'constantDefinitionPart_is_empty', 
         'constantList_is_constantList_constantDefinition', 
         'constantList_is_constantDefinition', 
         'constantDefinition_is_identifier_EQUAL_cexpression_semicolon', 
         'cexpression_is_csimpleExpression', 
         'cexpression_is_csimpleExpression_relop_csimpleExpression', 
         'csimpleExpression_is_cterm', 
         'csimpleExpression_is_csimpleExpression_addop_cterm', 
         'cterm_is_cfactor', 
         'cterm_is_cterm_mulop_cfactor', 
         'cfactor_is_sign_cfactor', 
         'cfactor_is_cexponentiation', 
         'cexponentiation_is_cprimary', 
         'cexponentiation_is_cprimary_STARSTAR_cexponentiation', 
         'cprimary_is_identifier', 
         'cprimary_is_LPAREN_cexpression_RPAREN', 
         'cprimary_is_unsignedConstant', 
         'cprimary_is_NOT_cprimary', 
         'constant_is_nonString', 
         'constant_is_sign_nonString', 
         'constant_is_CHARACTER_STRING', 
         'sign_is_PLUS', 
         'sign_is_MINUS', 
         'nonString_is_DIGSEQ', 
         'nonString_is_identifier', 
         'nonString_is_REALNUMBER', 
         'typeDefinitionPart_is_TYPE_typeDefinitionList', 
         'typeDefinitionPart_is_empty', 
         'typeDefinitionList_is_typeDefinitionList_typeDefinition', 
         'typeDefinitionList_is_typeDefinition', 
         'typeDefinition_is_identifier_EQUAL_typeDenoter_semicolon', 
         'typeDenoter_is_identifier', 
         'typeDenoter_is_newType', 
         'newType_is_newOrdinalType', 
         'newType_is_newStructuredType', 
         'newType_is_newPointerType', 
         'newOrdinalType_is_enumeratedType', 
         'newOrdinalType_is_subrangeType', 
         'enumeratedType_is_LPAREN_identifierList_RPAREN', 
         'subrangeType_is_constant_DOTDOT_constant', 
         'newStructuredType_is_structuredType', 
         'newStructuredType_is_PACKED_structuredType', 
         'structuredType_is_arrayType', 
         'structuredType_is_recordType', 
         'structuredType_is_setType', 
         'structuredType_is_fileType', 
         'arrayType_is_ARRAY_LBRAC_indexList_RBRAC_OF_componentType', 
         'indexList_is_indexList_comma_indexType', 
         'indexList_is_indexType', 
         'indexType_is_ordinalType', 
         'ordinalType_is_newOrdinalType', 
         'ordinalType_is_identifier', 
         'componentType_is_typeDenoter', 
         'recordType_is_RECORD_recordSectionList_END', 
         'recordType_is_RECORD_recordSectionList_semicolon_variantPart_END', 
         'recordType_is_RECORD_variantPart_END', 
         'recordSectionList_is_recordSectionList_semicolon_recordSection', 
         'recordSectionList_is_recordSection', 
         'recordSection_is_identifierList_COLON_typeDenoter', 
         'variantPart_is_CASE_variantSelector_OF_variantList_semicolon', 
         'variantPart_is_CASE_variantSelector_OF_variantList', 
         'variantPart_is_empty', 
         'variantSelector_is_tagField_COLON_tagType', 
         'variantSelector_is_tagType', 
         'variantList_is_variantList_semicolon_variant', 
         'variantList_is_variant', 
         'variant_is_caseConstantList_COLON_LPAREN_recordSectionList_RPAREN', 
         'variant_is_caseConstantList_COLON_LPAREN_recordSectionList_semicolon_variantPart_RPAREN', 
         'variant_is_caseConstantList_COLON_LPAREN_variantPart_RPAREN', 
         'caseConstantList_is_caseConstantList_comma_caseConstant', 
         'caseConstantList_is_caseConstant', 
         'caseConstant_is_constant', 
         'caseConstant_is_constant_DOTDOT_constant', 
         'tagField_is_identifier', 
         'tagType_is_identifier', 
         'setType_is_SET_OF_baseType', 
         'baseType_is_ordinalType', 
         'fileType_is_PFILE_OF_componentType', 
         'newPointerType_is_UPARROW_domainType', 
         'domainType_is_identifier', 
         'variableDeclarationPart_is_VAR_variableDeclarationList_semicolon', 
         'variableDeclarationPart_is_empty', 
         'variableDeclarationList_is_variableDeclarationList_semicolon_variableDeclaration', 
         'variableDeclarationList_is_variableDeclaration', 
         'variableDeclaration_is_identifierList_COLON_typeDenoter', 
         'procedureAndFunctionDeclarationPart_is_procOrFuncDeclarationList_semicolon', 
         'procedureAndFunctionDeclarationPart_is_empty', 
         'procOrFuncDeclarationList_is_procOrFuncDeclarationList_semicolon_procOrFuncDeclaration', 
         'procOrFuncDeclarationList_is_procOrFuncDeclaration', 
         'procOrFuncDeclaration_is_procedureDeclaration', 
         'procOrFuncDeclaration_is_functionDeclaration', 
         'procedureDeclaration_is_procedureHeading_semicolon_directive', 
         'procedureDeclaration_is_procedureHeading_semicolon_procedureBlock', 
         'procedureHeading_is_procedureIdentification', 
         'procedureHeading_is_procedureIdentification_formalParameterList', 
         'directive_is_FORWARD', 
         'directive_is_EXTERNAL', 
         'formalParameterList_is_LPAREN_formalParameterSectionList_RPAREN', 
         'formalParameterSectionList_is_formalParameterSectionList_semicolon_formalParameterSection', 
         'formalParameterSectionList_is_formalParameterSection', 
         'formalParameterSection_is_valueParameterSpecification', 
         'formalParameterSection_is_variableParameterSpecification', 
         'formalParameterSection_is_proceduralParameterSpecification', 
         'formalParameterSection_is_functionalParameterSpecification', 
         'valueParameterSpecification_is_identifierList_COLON_identifier', 
         'variableParameterSpecification_is_VAR_identifierList_COLON_identifier', 
         'proceduralParameterSpecification_is_procedureHeading', 
         'functionalParameterSpecification_is_functionHeading', 
         'procedureIdentification_is_PROCEDURE_identifier', 
         'procedureBlock_is_block', 
         'functionDeclaration_is_functionHeading_semicolon_directive', 
         'functionDeclaration_is_functionIdentification_semicolon_functionBlock', 
         'functionDeclaration_is_functionHeading_semicolon_functionBlock', 
         'functionHeading_is_FUNCTION_identifier_COLON_resultType', 
         'functionHeading_is_FUNCTION_identifier_formalParameterList_COLON_resultType', 
         'resultType_is_identifier', 
         'functionIdentification_is_FUNCTION_identifier', 
         'functionBlock_is_block', 
         'statementPart_is_compoundStatement', 
         'compoundStatement_is_PBEGIN_statementSequence_END', 
         'statementSequence_is_statementSequence_semicolon_statement', 
         'statementSequence_is_statement', 
         'statement_is_openStatement', 
         'statement_is_closedStatement', 
         'openStatement_is_label_COLON_nonLabeledOpenStatement', 
         'openStatement_is_nonLabeledOpenStatement', 
         'closedStatement_is_label_COLON_nonLabeledClosedStatement', 
         'closedStatement_is_nonLabeledClosedStatement', 
         'nonLabeledClosedStatement_is_assignmentStatement', 
         'nonLabeledClosedStatement_is_procedureStatement', 
         'nonLabeledClosedStatement_is_gotoStatement', 
         'nonLabeledClosedStatement_is_compoundStatement', 
         'nonLabeledClosedStatement_is_caseStatement', 
         'nonLabeledClosedStatement_is_repeatStatement', 
         'nonLabeledClosedStatement_is_closedWithStatement', 
         'nonLabeledClosedStatement_is_closedIfStatement', 
         'nonLabeledClosedStatement_is_closedWhileStatement', 
         'nonLabeledClosedStatement_is_closedForStatement', 
         'nonLabeledClosedStatement_is_empty', 
         'nonLabeledOpenStatement_is_openWithStatement', 
         'nonLabeledOpenStatement_is_openIfStatement', 
         'nonLabeledOpenStatement_is_openWhileStatement', 
         'nonLabeledOpenStatement_is_openForStatement', 
         'repeatStatement_is_REPEAT_statementSequence_UNTIL_booleanExpression', 
         'openWhileStatement_is_WHILE_booleanExpression_DO_openStatement', 
         'closedWhileStatement_is_WHILE_booleanExpression_DO_closedStatement', 
         'openForStatement_is_FOR_controlVariable_ASSIGNMENT_initialValue_direction_finalValue_DO_openStatement', 
         'closedForStatement_is_FOR_controlVariable_ASSIGNMENT_initialValue_direction_finalValue_DO_closedStatement', 
         'openWithStatement_is_WITH_recordVariableList_DO_openStatement', 
         'closedWithStatement_is_WITH_recordVariableList_DO_closedStatement', 
         'openIfStatement_is_IF_booleanExpression_THEN_statement', 
         'openIfStatement_is_IF_booleanExpression_THEN_closedStatement_ELSE_openStatement', 
         'closedIfStatement_is_IF_booleanExpression_THEN_closedStatement_ELSE_closedStatement', 
         'assignmentStatement_is_variableAccess_ASSIGNMENT_expression', 
         'variableAccess_is_identifier', 
         'variableAccess_is_indexedVariable', 
         'variableAccess_is_fieldDesignator', 
         'variableAccess_is_variableAccess_UPARROW', 
         'indexedVariable_is_variableAccess_LBRAC_indexExpressionList_RBRAC', 
         'indexExpressionList_is_indexExpressionList_comma_indexExpression', 
         'indexExpressionList_is_indexExpression', 
         'indexExpression_is_expression', 
         'fieldDesignator_is_variableAccess_DOT_identifier', 
         'procedureStatement_is_identifier_params', 
         'procedureStatement_is_identifier', 
         'params_is_LPAREN_actualParameterList_RPAREN', 
         'actualParameterList_is_actualParameterList_comma_actualParameter', 
         'actualParameterList_is_actualParameter', 
         'actualParameter_is_expression', 
         'actualParameter_is_expression_COLON_expression', 
         'actualParameter_is_expression_COLON_expression_COLON_expression', 
         'gotoStatement_is_GOTO_label', 
         'caseStatement_is_CASE_caseIndex_OF_caseListElementList_END', 
         'caseStatement_is_CASE_caseIndex_OF_caseListElementList_SEMICOLON_END', 
         'caseStatement_is_CASE_caseIndex_OF_caseListElementList_semicolon_otherwisepart_statement_END', 
         'caseStatement_is_CASE_caseIndex_OF_caseListElementList_semicolon_otherwisepart_statement_SEMICOLON_END', 
         'caseIndex_is_expression', 
         'caseListElementList_is_caseListElementList_semicolon_caseListElement', 
         'caseListElementList_is_caseListElement', 
         'caseListElement_is_caseConstantList_COLON_statement', 
         'otherwisepart_is_OTHERWISE', 
         'otherwisepart_is_OTHERWISE_COLON', 
         'controlVariable_is_identifier', 
         'initialValue_is_expression', 
         'direction_is_TO', 
         'direction_is_DOWNTO', 
         'finalValue_is_expression', 
         'recordVariableList_is_recordVariableList_comma_variableAccess', 
         'recordVariableList_is_variableAccess', 
         'booleanExpression_is_expression', 
         'expression_is_simpleExpression', 
         'expression_is_simpleExpression_relop_simpleExpression', 
         'simpleExpression_is_term', 
         'simpleExpression_is_simpleExpression_addop_term', 
         'term_is_factor', 
         'term_is_term_mulop_factor', 
         'factor_is_sign_factor', 
         'factor_is_exponentiation', 
         'exponentiation_is_primary', 
         'exponentiation_is_primary_STARSTAR_exponentiation', 
         'primary_is_variableAccess', 
         'primary_is_unsignedConstant', 
         'primary_is_functionDesignator', 
         'primary_is_setConstructor', 
         'primary_is_LPAREN_expression_RPAREN', 
         'primary_is_NOT_primary', 
         'unsignedConstant_is_unsignedNumber', 
         'unsignedConstant_is_CHARACTER_STRING', 
         'unsignedConstant_is_NIL', 
         'unsignedNumber_is_unsignedInteger', 
         'unsignedNumber_is_unsignedReal', 
         'unsignedInteger_is_DIGSEQ', 
         'unsignedReal_is_REALNUMBER', 
         'functionDesignator_is_identifier_params', 
         'setConstructor_is_LBRAC_memberDesignatorList_RBRAC', 
         'setConstructor_is_LBRAC_RBRAC', 
         'memberDesignatorList_is_memberDesignatorList_comma_memberDesignator', 
         'memberDesignatorList_is_memberDesignator', 
         'memberDesignator_is_memberDesignator_DOTDOT_expression', 
         'memberDesignator_is_expression', 
         'addop_is_PLUS', 
         'addop_is_MINUS', 
         'addop_is_OR', 
         'mulop_is_STAR', 
         'mulop_is_SLASH', 
         'mulop_is_DIV', 
         'mulop_is_MOD', 
         'mulop_is_AND', 
         'relop_is_EQUAL', 
         'relop_is_NOTEQUAL', 
         'relop_is_LT', 
         'relop_is_GT', 
         'relop_is_LE', 
         'relop_is_GE', 
         'relop_is_IN', 
         'identifier_is_IDENTIFIER', 
         'semicolon_is_SEMICOLON', 
         'comma_is_COMMA', );
  $self;
}

#line 562 "pascal.eyp"


use Carp;
use Getopt::Long;

my %keywords = (
  AND   => 'AND',
  ARRAY   => 'ARRAY',
  CASE   => 'CASE',
  CONST   => 'CONST',
  DIV   => 'DIV',
  DO    => 'DO',
  DOWNTO  => 'DOWNTO',
  ELSE   => 'ELSE',
  END   => 'END',
  EXTERN => 'EXTERNAL',
  EXTERNAL => 'EXTERNAL',
  FOR   => 'FOR',
  FORWARD  => 'FORWARD',
  FUNCTION => 'FUNCTION',
  GOTO   => 'GOTO',
  IF    => 'IF',
  IN    => 'IN',
  LABEL   => 'LABEL',
  MOD   => 'MOD',
  NIL   => 'NIL',
  NOT   => 'NOT',
  OF    => 'OF',
  OR    => 'OR',
  OTHERWISE => 'OTHERWISE',
  PACKED  => 'PACKED',
  BEGIN   => 'PBEGIN',
  FILE   => 'PFILE',
  PROCEDURE => 'PROCEDURE',
  PROGRAM  => 'PROGRAM',
  RECORD  => 'RECORD',
  REPEAT  => 'REPEAT',
  SET   => 'SET',
  THEN   => 'THEN',
  TO    => 'TO',
  TYPE   => 'TYPE',
  UNTIL   => 'UNTIL',
  VAR   => 'VAR',
  WHILE   => 'WHILE',
  WITH   => 'WITH',
);

my %lexeme = (
  ':=' => 'ASSIGNMENT',
  ':' => 'COLON',
  ',' => 'COMMA',
  '.' => 'DOT',
  '..' => 'DOTDOT',
  '=' => 'EQUAL',
  '>=' => 'GE',
  '>' => 'GT',
  '[' => 'LBRAC',
  '<=' => 'LE',
  '(' => 'LPAREN',
  '<' => 'LT',
  '-' => 'MINUS',
  '<>' => 'NOTEQUAL',
  '+' => 'PLUS',
  ']' => 'RBRAC',
  ')' => 'RPAREN',
  ';' => 'SEMICOLON',
  '/' => 'SLASH',
  '*' => 'STAR',
  '**' => 'STARSTAR',
  '->' => 'UPARROW',
  '^' => 'UPARROW',
);


my ($tokenbegin, $tokenend) = (1, 1);

sub _Lexer {
  my($parser)=shift;

  my $token;
  for ($parser->{INPUT}) {
      return('',undef) if !defined($_) or $_ eq '';

      #Skip blanks and comments
      s{\A
         ((?:
              \s+         # any white space char
          |   \(\*.*?\*\) # (*.. *) comments
          |   \{.*?\}     # { .. }  comments
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

      s{^([0-9]+(\.[0-9]+)?)}{} and do {
        return ('DIGSEQ', [$1, $tokenbegin]) unless defined($2);
        return ('REALNUMBER', [$1, $tokenbegin]);
      };

      s{^(\'(\\.|[^\\'])*\')}{}    
              and return('CHARACTER_STRING', [$1, $tokenbegin]);

      s/^([a-zA-Z_][A-Za-z0-9_]*)//
        and do {
          my $word = uc($1);
          my $r;
          return ($r, [$r, $tokenbegin]) if defined($r = $keywords{$word});
          return('IDENTIFIER',[$word, $tokenbegin]);
      };

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
  print $parser->Run( $debug )->str,"\n";
}

sub TERMINAL::info {
  $_[0]->{attr}[0]
};

__PACKAGE__->main unless caller();


=head1 NAME Pascal eyapp grammar

=head1 LIMITATIONS

A parameter declarations must be followed by an identifer.
A declaration like:

  procedure one (i, j : integer; k : array [1..5] of real);

instead we can do:

  type arrreal5 = array [1..5] of real; 

  procedure one (i, j : integer; k : arrreal5);

=cut




#line 6641 ./pascal.pm

unless (caller) {
  exit !__PACKAGE__->main('');
}


1;
