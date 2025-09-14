CREATE TABLE IF NOT EXISTS "applications" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"job_id" varchar(20) NOT NULL,
	"uid" varchar(20) NOT NULL,
	"current_status" varchar(255) DEFAULT 'applied' NOT NULL,
	"updated_at" date DEFAULT now(),
	"created_at" date DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "branches" (
	"branch_id" varchar(20) PRIMARY KEY NOT NULL,
	"name" varchar(255) NOT NULL,
	"description" text
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "colleges" (
	"college_id" varchar(20) PRIMARY KEY NOT NULL,
	"name" varchar(255) NOT NULL,
	"description" text,
	"logo_url" varchar(1024)
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "companies" (
	"company_id" varchar(20) NOT NULL,
	"name" varchar(255) NOT NULL,
	"description" text,
	"logo_url" varchar(1024),
	"questions" jsonb,
	CONSTRAINT "companies_company_id_unique" UNIQUE("company_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "jobs" (
	"job_id" varchar(20) NOT NULL,
	"college_id" varchar(20) NOT NULL,
	"company_id" varchar(20) NOT NULL,
	"role" varchar(255) NOT NULL,
	"deadline" date NOT NULL,
	"skills" text,
	"description" text,
	"jd_pdf_link" varchar(1024),
	"batch" varchar(255),
	"job_type" varchar(255) DEFAULT 'both' NOT NULL,
	"status" varchar(255) DEFAULT 'OPEN' NOT NULL,
	"status_date" date,
	"branches" varchar(1024),
	"created_at" date DEFAULT now(),
	"webinar_requested" numeric DEFAULT 0,
	"cgpa" real,
	"lpa" real,
	CONSTRAINT "jobs_job_id_unique" UNIQUE("job_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "mockInterview" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"jsonMockResp" jsonb NOT NULL,
	"job_id" varchar(20) NOT NULL,
	"uid" varchar(20) NOT NULL,
	"created_at" date DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "resumes" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"uid" varchar(20) NOT NULL,
	"data" text,
	"is_active" boolean NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "reviews" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"college_id" varchar(20) NOT NULL,
	"company_id" varchar(20) NOT NULL,
	"uid" varchar(20) NOT NULL,
	"review" text,
	"created_at" date DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "userAnswer" (
	"id" uuid PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"mock_id" uuid NOT NULL,
	"question" varchar(255) NOT NULL,
	"correctAns" jsonb,
	"userAns" jsonb,
	"feedback" jsonb,
	"rating" real,
	"uid" varchar(20) NOT NULL,
	"created_at" date DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "users" (
	"uid" varchar(20) PRIMARY KEY NOT NULL,
	"name" varchar(255) NOT NULL,
	"email" varchar(255) NOT NULL,
	"password" varchar(255) NOT NULL,
	"dob" date NOT NULL,
	"phone_no" bigint NOT NULL,
	"college_id" varchar(20) NOT NULL,
	"branch_id" varchar(20),
	"role" varchar(255) DEFAULT 'student' NOT NULL,
	"verified" boolean DEFAULT false NOT NULL,
	"batch" varchar(255),
	"cgpa" real,
	"resume_link" varchar(1024),
	"description" text,
	"profile_image_url" varchar(1024) DEFAULT 'https://cdn-icons-png.flaticon.com/512/9512/9512683.png',
	"companies" jsonb,
	CONSTRAINT "users_email_unique" UNIQUE("email"),
	CONSTRAINT "users_phone_no_unique" UNIQUE("phone_no")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "applications" ADD CONSTRAINT "applications_job_id_jobs_job_id_fk" FOREIGN KEY ("job_id") REFERENCES "public"."jobs"("job_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "applications" ADD CONSTRAINT "applications_uid_users_uid_fk" FOREIGN KEY ("uid") REFERENCES "public"."users"("uid") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "jobs" ADD CONSTRAINT "jobs_college_id_colleges_college_id_fk" FOREIGN KEY ("college_id") REFERENCES "public"."colleges"("college_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "jobs" ADD CONSTRAINT "jobs_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "mockInterview" ADD CONSTRAINT "mockInterview_job_id_jobs_job_id_fk" FOREIGN KEY ("job_id") REFERENCES "public"."jobs"("job_id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "mockInterview" ADD CONSTRAINT "mockInterview_uid_users_uid_fk" FOREIGN KEY ("uid") REFERENCES "public"."users"("uid") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "resumes" ADD CONSTRAINT "resumes_uid_users_uid_fk" FOREIGN KEY ("uid") REFERENCES "public"."users"("uid") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "reviews" ADD CONSTRAINT "reviews_college_id_colleges_college_id_fk" FOREIGN KEY ("college_id") REFERENCES "public"."colleges"("college_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "reviews" ADD CONSTRAINT "reviews_company_id_companies_company_id_fk" FOREIGN KEY ("company_id") REFERENCES "public"."companies"("company_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "reviews" ADD CONSTRAINT "reviews_uid_users_uid_fk" FOREIGN KEY ("uid") REFERENCES "public"."users"("uid") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "userAnswer" ADD CONSTRAINT "userAnswer_mock_id_mockInterview_id_fk" FOREIGN KEY ("mock_id") REFERENCES "public"."mockInterview"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "userAnswer" ADD CONSTRAINT "userAnswer_uid_users_uid_fk" FOREIGN KEY ("uid") REFERENCES "public"."users"("uid") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "users" ADD CONSTRAINT "users_college_id_colleges_college_id_fk" FOREIGN KEY ("college_id") REFERENCES "public"."colleges"("college_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "users" ADD CONSTRAINT "users_branch_id_branches_branch_id_fk" FOREIGN KEY ("branch_id") REFERENCES "public"."branches"("branch_id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
