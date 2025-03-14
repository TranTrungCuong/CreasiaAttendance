using Microsoft.Data.SqlClient;
using System.Data;

namespace CreasiaAttendance.Server.Helpers
{
    public class DatabaseHelper
    {
        private readonly string _connectionString;

        public DatabaseHelper(string connectionString)
        {
            _connectionString = connectionString;
        }

        private SqlConnection GetConnection()
        {
            return new SqlConnection(_connectionString);
        }

        public async Task<List<T>> ExecuteStoredProcedure<T>(string procedureName, Func<SqlDataReader, T> mapFunction)
        {
            List<T> result = new();
            using (var connect = GetConnection())
            {
                using (var cmd = new SqlCommand(procedureName, connect))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    await connect.OpenAsync();
                    using (var reader = await cmd.ExecuteReaderAsync())
                    {
                        while (await reader.ReadAsync())
                        {
                            result.Add(mapFunction(reader));
                        }
                    }
                }
            }
            return result;
        }
    }
}
