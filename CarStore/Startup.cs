using C.Tools.Security.Jwt.Configuration;
using C.Tools.Security.Jwt.Middlewares;
using C.Tools.Security.Jwt.Services;
using CarStore.DTO;

using CarStore.models.Repositories;
using CarStore.Models.Entities;
using CarStore.Models.Repositories;
using CarStore.Models.Services;
using CarStore.ServicesDTO;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.OpenApi.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace CarStore
{
    public class Startup
    {
        readonly string MyAllowSpecificOrigins = "_myAllowSpecificOrigins";
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {

            services.AddControllers();
            services.AddSwaggerGen(c =>
            {
                c.SwaggerDoc("v1", new OpenApiInfo { Title = "CarStore", Version = "v1" });
            });
            services.AddScoped<IDbConnection>((p) => new SqlConnection(Configuration.GetConnectionString("default")));
            JwtConfiguration config = Configuration.GetSection("Jwt").Get<JwtConfiguration>();
            services.AddSingleton(config);
            services.AddScoped<IBaseRepository<Marque>, MarqueService>();
            services.AddScoped<JwtService>();
            services.AddScoped<IBaseRepository<Piece>, PieceService>();
            services.AddScoped<IPieceRepository, PieceService>();
            services.AddScoped<IBaseRepository<Categorie_piece>, CategorieService>();
            services.AddScoped<IBaseRepository<Adresse>, AdresseService>();
            services.AddScoped<IBaseRepository<Utilisateur>, UtilisateurService>();
            services.AddScoped<IBaseRepository<Photo>, PhotoService>();
            services.AddScoped<IBaseRepository<Commande>, CommandeService>();
           
            services.AddScoped<PieceDTOService>();
           

            services.AddCors(option =>
            {
                option.AddPolicy(name: MyAllowSpecificOrigins,
                    builder =>
                    {
                        builder.AllowAnyOrigin();
                        builder.AllowAnyMethod();
                        builder.AllowAnyHeader();
                    });
            });
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseSwagger();
                app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "CarStore v1"));
            }
            app.UseMiddleware<JwtMiddleware>();
            app.UseCors(MyAllowSpecificOrigins);

            app.UseRouting();

            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllers();
            });
        }
    }
}
