import { v2 as cloudinary } from "cloudinary";

// Configuration
cloudinary.config({
  cloud_name: process.env.CLOUDINARY_CLOUD_NAME,  // take from .env
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET,
});

export function cloudinaryUpload(localPath, resource_type = "auto") {
  return cloudinary.uploader.upload(localPath, { resource_type });
}

export function cloudinaryDestroy(publicId) {
  return cloudinary.uploader.destroy(publicId);
}
