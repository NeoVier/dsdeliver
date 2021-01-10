[<CompilationRepresentation(CompilationRepresentationFlags.ModuleSuffix)>]
module Backend.Database

open FSharp.Data.Sql

[<Literal>]
let private Host = "localhost"

[<Literal>]
let private Database = "dsdeliver"

[<Literal>]
let private DevConnection = "Host=" + Host + ";Database=" + Database

let private connectionString =
    match System.Environment.GetEnvironmentVariable "DATABASE_URL" with
    | null -> DevConnection
    | valid -> valid


[<Literal>]
let private DbProvider = Common.DatabaseProviderTypes.POSTGRESQL

type private Sql = SqlDataProvider<DbProvider, Env.BackendUrl>

type ProductEntity = Sql.dataContext.``public.productEntity``
type OrderEntity = Sql.dataContext.``public.orderEntity``

type Context = Sql.dataContext

let context = Sql.GetDataContext connectionString
