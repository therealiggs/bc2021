*** Settings ***
Library    JsonValidator
Library    RequestsLibrary     WITH NAME    Req
Library    postgrest.Postgrest       WITH NAME    Rest
Library    sql.Sql    WITH NAME    Sql
Library    comparison    WITH NAME    Comp